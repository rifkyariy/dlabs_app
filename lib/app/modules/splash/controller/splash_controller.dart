import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AppStorageService _appStorageService = Get.put(AppStorageService());
  final AuthRepository _authRepository = Get.put(AuthRepository());

  late String? googleAuthKey;
  late String? googleFullName;
  late String? apiToken;
  late String? googlePhotoUrl;

  @override
  void onInit() async {
    super.onInit();

    // Get Shared Pereference Data

    googleAuthKey = await _appStorageService.readString('googleKey');
    apiToken = await _appStorageService.readString('apiToken');
    googleFullName = await _appStorageService.readString('googleFullName');
    googlePhotoUrl = await _appStorageService.readString('googlePhotoUrl');

    print(googleAuthKey);
    print(apiToken);
    print(googleFullName);
    print(googlePhotoUrl);
    // If no google auth key & api Token null (Logged Out)
    if (googleAuthKey == null && apiToken == null) {
      // Set Shared Pereference is Logged In to false.
      await _appStorageService.write('isLoggedIn', boolValue: false);

      // Go to dashboard without parameters.
      final _parameters = <String, String>{
        "photoUrl": '',
        "fullName": '',
        "gender": '1'
      };
      Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);

      // if google auth key exist.
    } else if (googleAuthKey != null) {
      // Check if google auth key still available.
      try {
        final _googleUser = await _authRepository.verifyGoogleAccount(
          accessToken: googleAuthKey ?? '',
          displayName: googleFullName ?? '',
        );

        print(_googleUser!.token);

        // If google user exist and status code from backend OK then go to dashboard with named
        if (_googleUser.status == '200') {
          await _appStorageService.write('isLoggedIn', boolValue: true);

          final _parameters = <String, String>{
            "photoUrl": googlePhotoUrl ?? '',
            "fullName": googleFullName ?? '',
          };

          Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);
        } else {
          await _appStorageService.write('isLoggedIn', boolValue: false);

          Get.snackbar(
            "Session Expired",
            "Please Login Again",
            backgroundColor: warningColor,
            colorText: whiteColor,
            snackPosition: SnackPosition.TOP,
          );

          // TODO dashboard atau ke signin
          Get.offAndToNamed(AppPages.signin);
          // Get.offAndToNamed(AppPages.dashboard);
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Unknown Error, Please try again later",
          backgroundColor: dangerColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else if (apiToken != null) {
      try {
        UserModel? _userData = await _authRepository.getUserData(
          token: apiToken ?? '',
        );

        if (_userData.status == '200') {
          await _appStorageService.write('isLoggedIn', boolValue: true);
          final _parameters = <String, String>{
            "photoUrl": _userData.image ?? '',
            "fullName": _userData.full_name ?? '',
          };
          Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);
        } else {
          Get.snackbar(
            "Session Expired",
            "Please Login Again",
            backgroundColor: warningColor,
            colorText: whiteColor,
            snackPosition: SnackPosition.TOP,
          );

          // TODO dashboard atau ke signin
          Get.offAndToNamed(AppPages.signin);
          // Get.offAndToNamed(AppPages.dashboard);
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Unknown Error, Please try again later",
          backgroundColor: dangerColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }
}
