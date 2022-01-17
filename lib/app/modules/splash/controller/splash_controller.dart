import 'dart:convert';

import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/user_model.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kayabe_lims/app/modules/dashboard/views/dashboard.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AppStorageService _storage = Get.put(AppStorageService());
  final AuthRepository _auth = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());
  final AuthController _authController =
      Get.put(AuthController(), permanent: true);

  RxString companyLogo = "".obs;
  RxBool isVisible = false.obs;

  late String? googleAuthKey;
  late String? googleFullName;
  late String? apiToken;
  late String storageCompanyLogo = "";
  late String? googlePhotoUrl;

  void getCompanyData() async {
    await _masterData.getCompanyData().then((company) {
      companyLogo.value = company['image'].toString();
      isVisible.value = true;
      _storage.write('companyLogo', stringValue: company['image'].toString());
      print(companyLogo);
    });
  }

  void isUserSignedIn() async {
    googleAuthKey = await _storage.readString('googleKey');
    apiToken = await _storage.readString('apiToken');
    googleFullName = await _storage.readString('googleFullName');
    googlePhotoUrl = await _storage.readString('googlePhotoUrl');

    print('google : $googleAuthKey');
    print('api token : $apiToken');
    print('google name : $googleFullName');
    print('google photo : $googlePhotoUrl');

    // If no google auth key & api Token null (Logged Out)
    if (googleAuthKey == null && apiToken == null) {
      // Set Shared Pereference is Logged In to false.
      await _storage.write('isLoggedIn', boolValue: false);
      _authController.isLoggedIn.value = false;

      // Go to dashboard without parameters.
      Get.offAndToNamed(AppPages.dashboard);

      // if google auth key exist.
    } else if (googleAuthKey != null) {
      // Check if google auth key still available.
      try {
        final _googleUser = await _auth.verifyGoogleAccount(
          accessToken: googleAuthKey ?? '',
          displayName: googleFullName ?? '',
        );

        // print(_googleUser.status);
        // If google user exist and status code from backend OK then go to dashboard with named
        if (_googleUser!.status == '200') {
          await _storage.write('isLoggedIn', boolValue: true);
          _authController.isLoggedIn.value = true;
          _authController.fullname.value = googleFullName!;
          _authController.photoUrl.value = googlePhotoUrl!;
          _authController.googleToken.value = googleAuthKey!;
          // _authController.gender.value = _appUser.gender!;
          // _authController.apiToken.value = _user.token!;

          Get.offAndToNamed(AppPages.dashboard);
        } else {
          /// Silent Login
          /// @_onGoogleTokenExpired()
          /// Login using google silent login.
          /// Must no token in locla storage

          _authController.onGoogleTokenExpired();
        }
      } catch (e) {
        Get.snackbar(
          "Something Went Wrong",
          "Please try again later",
          backgroundColor: primaryColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else if (apiToken != null) {
      try {
        UserModel? _userData = await _auth.getUserData(
          token: apiToken ?? '',
        );

        if (_userData.status == '200') {
          await _storage.write('isLoggedIn', boolValue: true);
          _authController.isLoggedIn.value = true;
          _authController.fullname.value = _userData.full_name!;
          _authController.photoUrl.value = _userData.image!;
          _authController.gender.value = _userData.gender!;
          _authController.googleToken.value = "";
          _authController.apiToken.value = apiToken!;

          Get.offAndToNamed(AppPages.dashboard);
        } else {
          /// Silent Login
          /// @_onApiTokenExpired()
          /// Get email and password from local storage
          _authController.onApiTokenExpired();
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Unknown Error, Please try again later",
          backgroundColor: primaryColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
