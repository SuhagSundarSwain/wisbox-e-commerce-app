import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/widgets/photo_chooser.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 06:55 PM
///
class EditProfilePage extends StatefulWidget {
  static const routeName = "/EditProfilePage";

  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DocumentSnapshot<Map<String, dynamic>>? profileData;
  bool _profileLoading = false;
  @override
  void initState() {
    super.initState();
    FirebaseCollectionRefs.userRef.get().then((value) {
      setState(() {
        profileData = value;
      });
    });
  }

  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      // body: ListView(
      //   padding: const EdgeInsets.all(16),
      //   children: [
      //     Center(
      //       child: GestureDetector(
      //         onTap: () {
      //           Get.bottomSheet(const PhotoChooser(cropStyle: CropStyle.circle),
      //                   backgroundColor: Get.theme.scaffoldBackgroundColor,
      //                   isScrollControlled: true)
      //               .then((value) {
      //             if (value != null && value is File) {
      //               uploadDp(value);
      //             }
      //           });
      //         },
      //         child: Stack(
      //           clipBehavior: Clip.none,
      //           children: [
      //             UserCircleAvatar(profileData?.data()?["image"],
      //                 name: profileData?.data()?["customerName"],
      //                 userId: profileData?.data()?["userUID"],
      //                 radius: 42),
      //             if (_profileLoading)
      //               const Positioned.fill(
      //                   child: CircularProgressIndicator(color: Colors.black)),
      //             const Positioned(
      //                 right: -2,
      //                 bottom: -2,
      //                 child: Material(
      //                     color: Colors.white,
      //                     type: MaterialType.circle,
      //                     child: Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: Icon(
      //                         Icons.camera,
      //                         size: 18,
      //                       ),
      //                     )))
      //           ],
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 12),
      //     Center(
      //       child: Text(
      //         snapshot.data?.data()?["customerName"] ?? "",
      //         textAlign: TextAlign.center,
      //         style: const TextStyle(
      //           fontSize: 22,
      //         ),
      //       ),
      //     ),
      //     Center(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 22),
      //         child: Text(
      //           snapshot.data?.data()?["formattedAddress"] ?? "",
      //           textAlign: TextAlign.center,
      //           style: const TextStyle(
      //             color: Color(0xff8E81F4),
      //             fontSize: 14,
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 32),
      //     const Text(
      //       'Email Id',
      //       style: TextStyle(
      //         fontSize: 14,
      //       ),
      //     ),
      //     const SizedBox(height: 4),
      //     Row(
      //       children: [
      //         const Icon(
      //           Icons.mail_outline,
      //           size: 18,
      //         ),
      //         const SizedBox(width: 4),
      //         Expanded(
      //             child: Text(
      //           snapshot.data?.data()?["email"] ?? "",
      //           style: const TextStyle(color: Color(0xff808080), fontSize: 16),
      //         ))
      //       ],
      //     ),
      //     const Divider(color: Colors.grey),
      //     const Text(
      //       'Phone number',
      //       style: TextStyle(
      //         fontSize: 14,
      //       ),
      //     ),
      //     const SizedBox(height: 4),
      //     Row(
      //       children: [
      //         const Icon(
      //           Icons.phone,
      //           size: 18,
      //         ),
      //         const SizedBox(width: 4),
      //         Expanded(
      //             child: Text(
      //           snapshot.data?.data()?["phNumber"] ?? "",
      //           style: const TextStyle(color: Color(0xff808080), fontSize: 16),
      //         ))
      //       ],
      //     ),
      //     const Divider(color: Colors.grey),
      //     const Text(
      //       'Gender',
      //       style: TextStyle(
      //         fontSize: 14,
      //       ),
      //     ),
      //     const SizedBox(height: 4),
      //     Row(
      //       children: const [
      //         Icon(
      //           Icons.male,
      //           size: 18,
      //         ),
      //         SizedBox(width: 4),
      //         Expanded(
      //             child: Text(
      //           "Male",
      //           style: TextStyle(color: Color(0xff808080), fontSize: 16),
      //         ))
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  void uploadDp(File value) async {}
}
