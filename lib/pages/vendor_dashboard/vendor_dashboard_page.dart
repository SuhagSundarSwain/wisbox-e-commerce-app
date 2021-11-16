import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/pages/dashboard/home/home_page.dart';
import 'package:nexmat/pages/dashboard/widgets/moment_icon_page.dart';
import 'package:nexmat/pages/dashboard/widgets/wallet_page.dart';
import 'package:nexmat/pages/profile/profile_page.dart';
import 'package:nexmat/pages/vendor_dashboard/widgets/vendor_cart_widget.dart';
import 'package:nexmat/pages/vendor_dashboard/widgets/vendor_home_user_details.dart';
import 'package:nexmat/pages/vendor_dashboard/widgets/vendor_products.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:44 PM
///
class VendorDashboardPage extends StatefulWidget {
  static const String routeName = '/vendor-dashboard';

  const VendorDashboardPage({Key? key}) : super(key: key);

  @override
  _VendorDashboardPageState createState() => _VendorDashboardPageState();
}

class _VendorDashboardPageState extends State<VendorDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        actionsIconTheme: IconThemeData(color: theme.primaryColor),
        title: Text(
          "NEXTMAT",
          style:
              TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          GestureDetector(
            onTap: () {
              Get.toNamed(ProfilePage.routeName);
            },
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseCollectionRefs.userRef.snapshots(),
                builder: (context, snapshot) {
                  return UserCircleAvatar(
                    snapshot.data?.data()?["image"],
                    name: snapshot.data?.data()?["customerName"],
                    userId: snapshot.data?.data()?["userUID"],
                    radius: 18,
                  );
                }),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: ListView(
        children: const [
          VendorHomeUserDetails(),
          VendorProducts(),
          VendorCartWidget(),
        ],
      ),
    );
  }
}
