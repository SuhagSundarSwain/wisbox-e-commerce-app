import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

import 'edit_profile_page.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 06:54 PM
///
class ProfileDetailsPage extends StatelessWidget {
  static const routeName = "/ProfileDetailsPage";

  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), actions: [
        TextButton(
            onPressed: () {
              Get.toNamed(EditProfilePage.routeName);
            },
            child: const Text("Edit"))
      ]),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseCollectionRefs.userRef.snapshots(),
          builder: (context, snapshot) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: UserCircleAvatar(
                    snapshot.data?.data()?["image"],
                    name: snapshot.data?.data()?["customerName"],
                    userId: snapshot.data?.data()?["userUID"],
                    radius: 42,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    snapshot.data?.data()?["customerName"] ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Text(
                      snapshot.data?.data()?["formattedAddress"] ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff8E81F4),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Email Id',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                        child: Text(
                      snapshot.data!.data()!["email"] ?? "",
                      style: const TextStyle(
                          color: Color(0xff808080), fontSize: 16),
                    ))
                  ],
                ),
                const Divider(color: Colors.grey),
                const Text(
                  'Phone number',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                        child: Text(
                      snapshot.data!.data()!["phNumber"] ?? "",
                      style: const TextStyle(
                          color: Color(0xff808080), fontSize: 16),
                    ))
                  ],
                ),
                const Divider(color: Colors.grey),
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(
                      Icons.male,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Expanded(
                        child: Text(
                      "Male",
                      style: TextStyle(color: Color(0xff808080), fontSize: 16),
                    ))
                  ],
                ),
              ],
            );
          }),
    );
  }
}
