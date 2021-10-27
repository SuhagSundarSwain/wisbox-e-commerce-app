import 'dart:io';

import 'package:get/get.dart';
import 'package:nexmat/api_services/base_api.dart';
import 'package:nexmat/app_configs/api_routes.dart';
import 'package:nexmat/data_models/user.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/utils/snackbar_helper.dart';
import 'package:nexmat/widgets/photo_chooser.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class UserController extends GetxController with StateMixin<UserDatum> {
  bool profileImageLoading = false;

  @override
  void onInit() {
    super.onInit();
  }

  void getUser() async {
    final d = SharedPreferenceHelper.user;
    if (d?.user == null) return;
    final result = await ApiCall.get(ApiRoutes.user,
        id: SharedPreferenceHelper.user!.user!.id);
    final user = UserDatum.fromJson(result.data);
    d!.user = user;

    SharedPreferenceHelper.storeUser(user: d);
    change(null, status: RxStatus.success());
    change(d.user, status: RxStatus.success());
  }

  void updateUser(UserDatum? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(null, status: RxStatus.success());
    change(user, status: RxStatus.success());
  }

  void updateProfileImage() async {
    final value = await Get.bottomSheet(PhotoChooser(),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        isScrollControlled: true);

    if (value != null && value is File) {
      try {
        profileImageLoading = true;
        update([1]);
        final uploadResponse = await ApiCall.singleFileUpload(value);
        final result = await ApiCall.patch(ApiRoutes.user,
            body: {"avatar": uploadResponse},
            id: SharedPreferenceHelper.user!.user!.id);
        final user = UserDatum.fromJson(result.data);
        final prefUser = SharedPreferenceHelper.user;
        prefUser?.user = user;
        SharedPreferenceHelper.storeUser(user: prefUser);
        updateUser(user);
      } catch (e) {
        SnackBarHelper.show(e.toString());
      } finally {
        profileImageLoading = false;
        update([1]);
      }
    }
  }
}
