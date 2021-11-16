import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nexmat/pages/splash/splash_screen.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_configs/app_page_routes.dart';
import 'app_configs/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nexmat',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      initialRoute: SplashPage.routeName,
      // transitionDuration: const Duration(seconds: 1),
      defaultTransition: Transition.fadeIn,
      getPages: AppPages.pages,
    );
  }
}
