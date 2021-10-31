import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/pages/onboarding/onboard_shop_details.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/widgets/alert_dialog.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:44 PM
///
class DashboardPage extends StatefulWidget {
  static const String routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nexmat"),
        actions: [
          IconButton(
              onPressed: () {
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
              icon: const Icon(Icons.power_settings_new_rounded))
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.toNamed(OnboardShopDetails.routeName);
              },
              child: const Text("Shop details"))
        ],
      ),
    );
  }
}
