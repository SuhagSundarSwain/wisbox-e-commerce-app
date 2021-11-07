import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/pages/store/store_details_page.dart';
import 'package:nexmat/utils/common_functions.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 31-10-2021 08:51 PM
///
class NearByShopTile extends StatelessWidget {
  const NearByShopTile(this.data, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>?> data;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Get.toNamed(StoreDetailsPage.routeName, arguments: {"id": data.id});
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  data.data()?["image"] ?? "",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                  data.data()?["storeName"] ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(width: 8),
                Material(
                  color: const Color(0xffC245BA),
                  shape: const StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                    child: Text(
                      data.data()?["storeCategory"] ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(width: 8),
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Expanded(child: Text(data.data()?["formattedAddress"])),
                const SizedBox(width: 8),
                const Icon(
                  Icons.directions_walk,
                  size: 20,
                  color: Colors.grey,
                ),
                Text("${calculateDistance(
                  data.data()?["lat"] ?? 0,
                  data.data()?["lng"] ?? 0,
                  SharedPreferenceHelper.location!.lat,
                  SharedPreferenceHelper.location!.lng,
                ).toStringAsFixed(1)} km"),
                const SizedBox(width: 6),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
