import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.brightBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    backgroundColor: AppColors.brightBackground,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: const IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.white)),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
  );
  static final darkTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.darkBackground,
    backgroundColor: AppColors.darkBackground,
    primarySwatch: AppColors.darkPrimary,
    primaryColor: AppColors.darkPrimary,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.darkPrimary,
        selectionHandleColor: AppColors.darkPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: const IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.darkPrimary),
    ),
  );
}
