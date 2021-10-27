import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:nexmat/data_models/user.dart';
import 'package:nexmat/global_controllers/user_controller.dart';
import 'package:nexmat/pages/dashboard/dashboard_page.dart';
import 'package:nexmat/pages/intro/intro_page.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel() async {
    final UserResponse? user = SharedPreferenceHelper.user;
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    if (user != null) {
      // if ((user.user?.name?.isEmpty ?? true)) {
      //   Get.offNamed(OnBoardingPage.routeName, arguments: {'index': 0});
      // } else if (user.user?.gender == null) {
      //   Get.offNamed(OnBoardingPage.routeName, arguments: {'index': 1});
      // } else if (user.user?.dob == null) {
      //   Get.offNamed(OnBoardingPage.routeName, arguments: {'index': 2});
      // } else if (user.user?.studentClass == null) {
      //   Get.offNamed(OnBoardingPage.routeName, arguments: {'index': 3});
      // } else {
      userController.updateUser(user.user);
      Get.offAllNamed(DashboardPage.routeName);
      // }
    } else if (SharedPreferenceHelper.firstTime) {
      Get.offAllNamed(IntroPage.routeName);
    } else {
      Get.offAllNamed(LoginPage.routeName);
    }
  }

  static Future<String?> logoutUser() async {
    // await ApiCall.post('authentication', basePath: ApiRoutes.baseUrl);
    SharedPreferenceHelper.logout();
    Get.offAllNamed(LoginPage.routeName);
    if (Get.isRegistered<UserController>()) {
      Get.find<UserController>().updateUser(null);
    }
  }
}
