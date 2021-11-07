import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/pages/dashboard/dashboard_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/utils/snackbar_helper.dart';
import 'package:nexmat/widgets/app_buttons/app_primary_button.dart';
import 'package:nexmat/widgets/photo_chooser.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:44 PM
///
class OnboardShopDetails extends StatefulWidget {
  static const String routeName = '/OnboardShopDetails';

  const OnboardShopDetails({Key? key}) : super(key: key);

  @override
  _OnboardShopDetailsState createState() => _OnboardShopDetailsState();
}

class _OnboardShopDetailsState extends State<OnboardShopDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _btnKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  File? _storeImage;
  String? _storeName, _gstId;
  TimeOfDay? _openingTime, _closingTime;
  int? _storeType;
  String? _category;

  late CollectionReference<Map<String, dynamic>> storeCategoriesRef;

  @override
  void initState() {
    super.initState();
    storeCategoriesRef = FirebaseFirestore.instance.collection("StoreCategory");
  }

  @override
  Widget build(BuildContext context) {
    _btnKey.currentState?.hideLoader();

    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              const Text(
                "Shop Details",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(const PhotoChooser(),
                          backgroundColor: Colors.white)
                      .then((value) {
                    if (value != null) {
                      _storeImage = value;
                      setState(() {});
                    }
                  });
                },
                child: Container(
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: _storeImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.addImage),
                            const SizedBox(height: 8),
                            const Text("Upload Shop Image")
                          ],
                        )
                      : Image.file(
                          _storeImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _storeName = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Shop Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _gstId = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'GST Id'),
              ),
              const SizedBox(height: 12),
              const Text(
                "Select your business identity",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                        child: StoreTypeTile(
                      title: "Stall",
                      avatar: AppAssets.stall,
                      selected: _storeType == 1,
                      onTap: () {
                        setState(() {
                          _storeType = 1;
                        });
                      },
                    )),
                    Expanded(
                        child: StoreTypeTile(
                      title: "Shop",
                      avatar: AppAssets.shop,
                      selected: _storeType == 2,
                      onTap: () {
                        setState(() {
                          _storeType = 2;
                        });
                      },
                    )),
                    Expanded(
                        child: StoreTypeTile(
                      title: "Showroom",
                      avatar: AppAssets.showroom,
                      selected: _storeType == 3,
                      onTap: () {
                        setState(() {
                          _storeType = 3;
                        });
                      },
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Category of product",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: storeCategoriesRef.snapshots(),
                builder: (context, snapshot) => snapshot.hasData
                    ? DropdownButtonFormField<String>(
                        validator: (s) {
                          if (s == null) {
                            return '*required';
                          }
                        },
                        onSaved: (s) {
                          _category = s;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                        ),
                        onChanged: (s) {
                          setState(() {
                            _category = s;
                          });
                        },
                        value: _category,
                        items: snapshot.data!.docs
                            .map(
                              (e) => DropdownMenuItem(
                                  child: Text(e.data()['text']),
                                  value: e.data()['text'].toString()),
                            )
                            .toList())
                    : const SizedBox(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Opening time",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  _openingTime = value;
                                });
                              }
                            });
                          },
                          child: Text(_openingTime == null
                              ? "Select"
                              : _openingTime!.format(context))),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Closing time",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  _closingTime = value;
                                });
                              }
                            });
                          },
                          child: Text(_closingTime == null
                              ? "Select"
                              : _closingTime!.format(context))),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                child: const Text("Create store"),
                onPressed: _submit,
                key: _btnKey,
              ),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }

  _submit() async {
    final state = _formKey.currentState;
    if (state == null) return;
    if (state.validate()) {
      if (_storeImage == null) {
        SnackBarHelper.show("Please select a store image.");
      } else if (_storeImage == null) {
        SnackBarHelper.show("Please select a store image.");
      } else if (_openingTime == null) {
        SnackBarHelper.show("Please choose opening time.");
      } else if (_closingTime == null) {
        SnackBarHelper.show("Please choose closing time.");
      } else {
        state.save();
        _btnKey.currentState?.showLoader();
        try {
          final user = SharedPreferenceHelper.user;
          if (user == null) throw "Not authenticated";
          Reference storageReference = FirebaseStorage.instance.ref().child(
              "img/${user.email}/BImg/${DateTime.now().millisecondsSinceEpoch}.jpg");

          final UploadTask uploadTask = storageReference.putFile(_storeImage!);
          final TaskSnapshot downloadUrl = uploadTask.snapshot;

          String url = "";
          uploadTask.snapshotEvents.listen((event) async {
            if (event.state == TaskState.success) {
              url = await downloadUrl.ref.getDownloadURL();

              await FirebaseCollectionRefs.storesRef.doc(user.email).update({
                "storeName": _storeName,
                "storeCategory": _category,
                "storeType": _storeType,
                "openingTime": _openingTime!.format(context),
                "closingTime": _closingTime!.format(context),
                "gstId": _gstId,
                "image": url
              });
              _btnKey.currentState?.hideLoader();
              Get.offAllNamed(DashboardPage.routeName);
            }
          });
        } catch (e, s) {
          SnackBarHelper.show(parseFirebaseError(e));
          log("ERROR", stackTrace: s, error: e);
          _btnKey.currentState?.hideLoader();
        }
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}

class StoreTypeTile extends StatelessWidget {
  final String title, avatar;
  final bool selected;
  final VoidCallback? onTap;
  const StoreTypeTile(
      {this.onTap,
      required this.avatar,
      required this.title,
      this.selected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(4),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Column(
                  children: [
                    Expanded(child: Image.asset(avatar)),
                    const SizedBox(height: 6),
                    Text(title),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          if (selected)
            const Positioned(
                right: 2,
                top: 2,
                child: Material(
                    type: MaterialType.circle,
                    color: Color(0xffAECEFF),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Icon(Icons.done, size: 16),
                    )))
        ],
      ),
    );
  }
}
