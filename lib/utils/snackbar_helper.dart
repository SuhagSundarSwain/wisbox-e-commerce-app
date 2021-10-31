import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarHelper {
  static Future<void> show(String message, {isLong = false}) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT);
  }
}
