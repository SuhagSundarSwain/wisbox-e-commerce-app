import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:nexmat/app_configs/environment.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/user_address_data.dart';
import 'package:nexmat/pages/dashboard/user_dashboard_page.dart';
import 'package:nexmat/pages/onboarding/onboard_shop_details.dart';
import 'package:nexmat/utils/check_permissions.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/utils/snackbar_helper.dart';
import 'package:nexmat/widgets/app_error_widget.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:43 PM
///
class SelectLocationPage extends StatefulWidget {
  static const String routeName = '/SelectLocationPage';

  const SelectLocationPage({Key? key}) : super(key: key);

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late TextEditingController _textEditingController;
  Timer? _debounce;
  int _debounceTime = 700;
  String _searchQuery = '';
  late bool isIndividual = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()..addListener(_textChange);
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      isIndividual = map["isIndividual"] ?? false;
    }
  }

  _textChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () async {
      // if (_searchTextController.text != "") {
      ///Search
      _searchQuery = _textEditingController.text.trim();
      list = await placesSearch(_searchQuery);
      if (mounted) {
        setState(() {});
      }
      // }
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_textChange);
    _textEditingController.dispose();
    super.dispose();
  }

  List<MapBoxPlace> list = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (Navigator.canPop(context))
                const Align(
                    alignment: Alignment.centerLeft, child: BackButton()),
              const SizedBox(height: 22),
              const Text(
                "Let’s Start",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 16),
              Material(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.antiAlias,
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search for your location"),
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                  onPressed: () async {
                    final data = await CheckPermissions.requestGpsService();
                    if (data != null) {
                      list = await geoCoding(data.latitude!, data.longitude!);
                      setState(() {});
                      if (list.isNotEmpty) {
                        _selectLocation(list.first);
                      } else {
                        SnackBarHelper.show("Location not found");
                      }
                    }
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text("Use current location")),
              const Divider(
                height: 0,
                color: Colors.grey,
              ),
              Expanded(
                  child:
                      // list.isEmpty
                      //     ? const AppEmptyWidget(
                      //         title: "No places found",
                      //       )
                      //     :
                      ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                _selectLocation(list[index]);
                              },
                              title: Text(list[index].placeName ?? ""),
                              // subtitle: Text(list[index].addressNumber ?? ""),
                            );
                          },
                          itemCount: list.length))
            ],
          ),
        ),
      ),
    );
  }

  _selectLocation(MapBoxPlace place) {
    final latLng = place.geometry?.coordinates ?? [0, 0];
    final formattedAddress = place.placeName ?? "";

    final UserAddressData data = UserAddressData(
        lat: latLng.first,
        lng: latLng.last,
        country: extractName(place, "country"),
        state: extractName(place, "region"),
        district: extractName(place, "district"),
        placeName: extractName(place, "place"),
        locality: extractName(place, "locality"),
        formattedAddress: formattedAddress);
    SharedPreferenceHelper.storeLocation(data);
    FirebaseCollectionRefs.userRef.update(data.toJson());
    if (SharedPreferenceHelper.user?.type == 1) {
      FirebaseCollectionRefs.storesRef
          .doc(SharedPreferenceHelper.user!.email)
          .update(data.toJson());
    }
    if (isIndividual) {
      Get.back();
    } else {
      if (SharedPreferenceHelper.user!.type == 1) {
        Get.toNamed(OnboardShopDetails.routeName);
      } else {
        Get.offAllNamed(DashboardPage.routeName);
      }
    }
  }

  Future<List<MapBoxPlace>> placesSearch(String query) async {
    final placesService = PlacesSearch(
      apiKey: Environment.mapBoxApiKey,
      country: "IN",
      limit: 20,
    );

    final places = await placesService.getPlaces(
      query.trim(),
      // location: Location(
      //   lat: -19.984634,
      //   lng: -43.9502958,
      // ),
    );
    return places ?? [];
  }

  Future<List<MapBoxPlace>> geoCoding(double lat, double lng) async {
    final geoCodingService = ReverseGeoCoding(
      apiKey: Environment.mapBoxApiKey,
      country: "IN",
      limit: 20,
    );

    final places = await geoCodingService.getAddress(Location(
      lat: lat,
      lng: lng,
    ));
    return places ?? [];
  }

  String extractName(MapBoxPlace place, String key) {
    if (place.context == null) return "";
    final index = place.context!.indexWhere(
        (element) => (element.id ?? ".").split(".").first.toLowerCase() == key);
    if (index != -1) {
      return place.context![index].text ?? "";
    }
    return "";
  }
}
