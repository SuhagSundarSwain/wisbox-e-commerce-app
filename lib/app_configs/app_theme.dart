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
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
      ),
      appBarTheme: const AppBarTheme(
          color: AppColors.brightBackground,
          foregroundColor: AppColors.brightPrimary,
          iconTheme: IconThemeData(
            color: AppColors.brightPrimary,
          ),
          actionsIconTheme: IconThemeData(
            color: AppColors.brightPrimary,
          ),
          centerTitle: true,
          elevation: 0));
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
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.darkPrimary),
    ),
  );
}
