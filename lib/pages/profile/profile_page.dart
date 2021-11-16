import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/pages/product/add_product_page.dart';
import 'package:nexmat/pages/product/vendor_products_page.dart';
import 'package:nexmat/pages/profile/widgets/edit_profile_page.dart';
import 'package:nexmat/pages/profile/widgets/profile_details_page.dart';
import 'package:nexmat/pages/profile/widgets/profile_my_saves_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/widgets/alert_dialog.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 06:51 PM
///
class ProfilePage extends StatefulWidget {
  static const routeName = "/ProfilePage";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(EditProfilePage.routeName);
              },
              child: const Text("Edit"))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseCollectionRefs.userRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
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
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ListTile(
                onTap: () {
                  Get.toNamed(ProfileDetailsPage.routeName);
                },
                title: const Text("My profile"),
                leading: SvgPicture.asset(AppAssets.person, width: 16)),
          ),
          if (SharedPreferenceHelper.user?.type == 2) ...[
            Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: ListTile(
                  onTap: () {
                    Get.toNamed(AddProductPage.routeName);
                  },
                  title: const Text("Add Product"),
                  leading: SvgPicture.asset(AppAssets.person, width: 16)),
            ),
            Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: ListTile(
                  onTap: () {
                    Get.toNamed(VendorProductsPage.routeName);
                  },
                  title: const Text("My Product"),
                  leading: SvgPicture.asset(AppAssets.person, width: 16)),
            )
          ],
          Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ListTile(
                onTap: () {
                  Get.toNamed(ProfileMySavesPage.routeName);
                },
                title: const Text("My saves"),
                leading: Center(
                    widthFactor: 1,
                    child: SvgPicture.asset(AppAssets.mySaves, width: 12))),
          ),
          Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ListTile(
                title: const Text("Help and support"),
                onTap: () {},
                leading: Center(
                    widthFactor: 1,
                    child: SvgPicture.asset(AppAssets.helpSupport, width: 16))),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ListTile(
                onTap: () {},
                title: const Text("Settings"),
                leading: Center(
                  widthFactor: 1,
                  child: SvgPicture.asset(
                    AppAssets.settings,
                    width: 16,
                  ),
                )),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ListTile(
                title: const Text("Log out"),
                onTap: () {
                  showAppAlertDialog(
                          title: "Logout?",
                          description: "Are you sure want to logout?")
                      .then((value) {
                    if (value == true) {
                      FirebaseAuth.instance.signOut();
                      SharedPreferenceHelper.logout();
                      Get.offAllNamed(LoginPage.routeName);
                    }
                  });
                },
                leading: Center(
                    widthFactor: 1,
                    child: SvgPicture.asset(AppAssets.logout, width: 16))),
          ),
        ],
      ),
    );
  }
}
