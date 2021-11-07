import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/utils/common_functions.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/widgets/app_error_widget.dart';
import 'package:nexmat/widgets/app_loader.dart';
import 'nearby_shop_tile.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 05-11-2021 08:34 PM
///
class NearByStores extends StatelessWidget {
  const NearByStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
        stream: FirebaseCollectionRefs.storesRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorWidget(title: parseFirebaseError(snapshot.error));
          }
          if (snapshot.hasData) {
            List docs = snapshot.data!.docs
                .where((element) =>
                    calculateDistance(
                      element.data()?["lat"] ?? 0,
                      element.data()?["lng"] ?? 0,
                      SharedPreferenceHelper.location!.lat,
                      SharedPreferenceHelper.location!.lng,
                    ) <=
                    10)
                .toList();
            if (docs.length > 4) docs = docs.take(4).toList();
            return Column(
                children: docs.map((e) => NearByShopTile(e)).toList());
          } else {
            return const Center(child: AppProgress());
          }
        });
  }
}
