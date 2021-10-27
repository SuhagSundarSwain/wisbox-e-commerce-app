import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/pages/dashboard/dashboard_page.dart';
import 'package:nexmat/pages/login/login_page.dart';

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
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAllNamed(DashboardPage.routeName);
      } else {
        Get.offAllNamed(LoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff303030),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/icons/logo.png", width: 60)),
            const SizedBox(height: 12),
            const Text(
              "A-Plus",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ));
  }
}
