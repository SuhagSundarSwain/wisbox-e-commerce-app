import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppColors {
  static const brightBackground = Color(0xfff8f8f8);
  static const darkBackground = Color(0xff3e3e3e);

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFE4E5E7),
    100: Color(0xFFBABFC4),
    200: Color(0xFF8D959D),
    300: Color(0xFF5F6A75),
    400: Color(0xFF3C4A58),
    500: Color(brightPrimaryValue),
    600: Color(0xFF172534),
    700: Color(0xFF131F2C),
    800: Color(0xFF0F1925),
    900: Color(0xFF080F18),
  });
  static const int brightPrimaryValue = 0xFF1A2A3A;

  static const MaterialColor darkPrimary =
      MaterialColor(darkPrimaryValue, <int, Color>{
    50: Color(0xFFE4E5E7),
    100: Color(0xFFBABFC4),
    200: Color(0xFF8D959D),
    300: Color(0xFF5F6A75),
    400: Color(0xFF3C4A58),
    500: Color(darkPrimaryValue),
    600: Color(0xFF172534),
    700: Color(0xFF131F2C),
    800: Color(0xFF0F1925),
    900: Color(0xFF080F18),
  });
  static const int darkPrimaryValue = 0xFF1A2A3A;
}
