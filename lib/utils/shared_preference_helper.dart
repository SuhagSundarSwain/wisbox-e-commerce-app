import 'dart:convert';
import 'package:nexmat/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const USER_KEY = 'user';
  static const FIRST_TIME_KEY = 'first-time';

  static SharedPreferences? preferences;

  static void clear() {
    preferences?.clear();
  }

  static void logout() {
    preferences?.remove(USER_KEY);
    preferences?.remove(FIRST_TIME_KEY);
  }

  static void storeFirstTime() {
    preferences?.setBool(FIRST_TIME_KEY, true);
  }

  static bool get firstTime => preferences?.getBool(FIRST_TIME_KEY) ?? false;

  static void storeUser({UserResponse? user, String? response}) {
    if (user != null) {
      preferences?.setString(USER_KEY, userResponseToJson(user));
    } else {
      if (response == null || response.isEmpty) {
        throw 'No value to store. Either a User object or a String response is required to store in preference.';
      } else {
        preferences?.setString(USER_KEY, response);
      }
    }
  }

  static UserResponse? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userResponseFromJson(preferences?.getString(USER_KEY) ?? '');
}
