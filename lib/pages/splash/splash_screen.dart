import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/user.dart';
import 'package:nexmat/pages/dashboard/user_dashboard_page.dart';
import 'package:nexmat/pages/intro/intro_page.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/pages/vendor_dashboard/vendor_dashboard_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 3)).then((value) async {
        if (FirebaseAuth.instance.currentUser != null) {
          final userData = await FirebaseCollectionRefs.userRef.get();
          SharedPreferenceHelper.storeUser(UserDatum(
              uid: userData.data()!["userUID"],
              email: userData.data()!["email"],
              name: userData.data()!["customerName"],
              type: userData.data()!["userTypeID"]));
          if (userData.data()?["userTypeID"] == 1) {
            Get.offAllNamed(VendorDashboardPage.routeName);
          } else {
            Get.offAllNamed(DashboardPage.routeName);
          }
        } else if (!SharedPreferenceHelper.firstTime) {
          Get.offAllNamed(IntroPage.routeName);
        } else {
          Get.offAllNamed(LoginPage.routeName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff303030),
        body:
            Center(child: Image.asset(AppAssets.splashAnimation, width: 200)));
  }
}
