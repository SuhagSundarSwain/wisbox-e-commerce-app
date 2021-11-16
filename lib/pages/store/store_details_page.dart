import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/pages/dashboard/home/widgets/deal_of_ther_slider.dart';
import 'package:nexmat/pages/product/product_details_page.dart';
import 'package:nexmat/pages/profile/widgets/profile_details_page.dart';
import 'package:nexmat/pages/store/widgets/store_deatils_slider.dart';
import 'package:nexmat/widgets/app_error_widget.dart';
import 'package:nexmat/widgets/app_loader.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 11:53 AM
///
class StoreDetailsPage extends StatefulWidget {
  static const routeName = "/StoreDetailsPage";

  const StoreDetailsPage({Key? key}) : super(key: key);

  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  late String storeId;
  @override
  void initState() {
    super.initState();
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      storeId = map["id"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseCollectionRefs.storesRef.doc(storeId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppErrorWidget(
                    title: parseFirebaseError(snapshot.error));
              }
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    StoreDetailsSlider(snapshot.data?.data()),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            snapshot.data?.data()?["storeName"] ?? "",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                          const SizedBox(width: 16),
                          const Material(
                            color: Color(0xffA398F9),
                            shape: StadiumBorder(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                              child: Text(
                                "WOW!",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 4, 22, 8),
                      child: Text(
                        snapshot.data?.data()?["formattedAddress"] ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 22, 16, 12),
                      child: Text(
                        "Our Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 240,
                      color: const Color(0xffa880ff),
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream:
                            FirebaseCollectionRefs.storeItemsRef.snapshots(),
                        builder: (context, s) {
                          if (s.hasData) {
                            final list = s.data?.docs
                                .where((element) =>
                                    element.data()["store"] ==
                                    snapshot.data?.data()?["userUID"])
                                .toList();
                            if (list == null || list.isEmpty) {
                              return const AppEmptyWidget(title: "No products");
                            }
                            return ListView.builder(
                                padding: const EdgeInsets.only(left: 16),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(ProductDetailsPage.routeName,
                                          arguments: {"id": list[index].id});
                                    },
                                    child: DealOfDayProduct(
                                        image: list[index].data()["image"],
                                        name: list[index].data()["name"],
                                        price: list[index].data()["price"]),
                                  );
                                },
                                itemCount: list.length);
                          } else {
                            return const Center(child: AppProgress());
                          }
                        },
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: AppProgress());
              }
            }),
      ),
    );
  }
}
