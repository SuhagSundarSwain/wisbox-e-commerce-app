// import 'package:geolocation/geolocation.dart';
import 'package:location/location.dart' as l;
import 'package:permission_handler/permission_handler.dart';

class CheckPermissions {
  static Future requestGpsService() async {
    // try {
    //   GeolocationResult result = await Geolocation.enableLocationServices();
    //   if (result == null || !result.isSuccessful) {
    //     throw 'Please Enable GPS to continue';
    //   }
    // } catch (e) {
    //   throw 'Please Enable GPS to continue';
    // }
  }

  static Future<l.LocationData> requestLocation() async {
    // if (Platform.isIOS) {
    //   final GeolocationResult result =
    //       await Geolocation.requestLocationPermission(
    //     permission: LocationPermission(
    //       ios: LocationPermissionIOS.always,
    //     ),
    //     openSettingsIfDenied: true,
    //   );
    //   if (result.isSuccessful) {
    //     return getLocation();
    //   } else {
    //     switch (result.error.type) {
    //       case GeolocationResultErrorType.serviceDisabled:
    //         throw 'Please Enable GPS to continue';
    //       case GeolocationResultErrorType.locationNotFound:
    //         throw 'Unable to get your location';
    //       case GeolocationResultErrorType.permissionDenied:
    //         throw 'Please Allow Location permission to continue';
    //       case GeolocationResultErrorType.playServicesUnavailable:
    //         throw 'Install play services in your phone to continue';
    //       case GeolocationResultErrorType.permissionNotGranted:
    //         throw 'Please Allow Location permission to continue';
    //       default:
    //         throw 'Please Allow Location permission to continue';
    //     }
    //   }
    // } else {
    var result = await Permission.location.request();
    if (result.isGranted) {
      await requestGpsService();
      return getLocation();
    }
    if (result.isDenied) {
      throw 'Please Allow Location permission to continue';
    }
    if (result.isPermanentlyDenied) {
      throw 'Please Allow Location permission in app settings to continue';
      // AppSettings.openAppSettings();
    }
    // }
    throw 'Please Allow Location permission to continue';
  }

  static Future<l.LocationData> getLocation() async {
    l.Location location = l.Location();
    var loc = await location.getLocation().timeout(Duration(seconds: 10),
        onTimeout: () {
      throw 'Unable to fetch your location';
    });
    return loc;
  }

  static Future<bool> storagePermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      var result = await Permission.storage.request();
      if (result.isDenied) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
