import 'dart:convert';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:nexmat/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const USER_KEY = 'user';
  static const FIRST_TIME_KEY = 'first-time';
  static const LOCATION_KEY = 'location';

  static SharedPreferences? preferences;

  static void clear() {
    preferences?.clear();
  }

  static void logout() {
    preferences?.remove(USER_KEY);
    preferences?.remove(LOCATION_KEY);
  }

  static void storeFirstTime() {
    preferences?.setBool(FIRST_TIME_KEY, true);
  }

  static bool get firstTime => preferences?.getBool(FIRST_TIME_KEY) ?? false;

  static void storeUser(UserDatum? user) {
    if (user != null) {
      preferences?.setString(USER_KEY, userToJson(user));
    }
  }

  static UserDatum? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userFromJson(preferences?.getString(USER_KEY) ?? '{}');

  static void storeLocation(MapBoxPlace place) {
    preferences?.setString(LOCATION_KEY, place.toRawJson());
  }

  static MapBoxPlace? get location =>
      preferences?.getString(LOCATION_KEY) == null
          ? null
          : MapBoxPlace.fromRawJson(preferences!.getString(LOCATION_KEY)!);
}
