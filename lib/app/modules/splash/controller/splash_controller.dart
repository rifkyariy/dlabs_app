import 'dart:convert';

import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/user_model.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kayabe_lims/app/modules/dashboard/views/dashboard.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AppStorageService _storage = Get.put(AppStorageService());
  final AuthRepository _auth = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());

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

    // If no google auth key & api Token null (Logged Out)
    if (googleAuthKey == null && apiToken == null) {
      // Set Shared Pereference is Logged In to false.
      await _storage.write('isLoggedIn', boolValue: false);

      // Go to dashboard without parameters.
      Get.off(
        () => const DashboardScreen(),
        binding: DashboardBinding(),
      );

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

          Get.off(
            () => DashboardScreen(
              photoUrl: googlePhotoUrl,
              fullName: googleFullName,
            ),
            binding: DashboardBinding(),
          );
        } else {
          /// Silent Login
          /// @_onGoogleTokenExpired()
          /// Login using google silent login.
          /// Must no token in locla storage

          _onGoogleTokenExpired();
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

          Get.off(
            () => DashboardScreen(
              photoUrl: _userData.image,
              fullName: _userData.full_name,
              gender: _userData.gender,
            ),
            binding: DashboardBinding(),
          );
        } else {
          /// Silent Login
          /// @_onApiTokenExpired()
          /// Get email and password from local storage
          _onApiTokenExpired();
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

  Future<UserModel?> _apiSilentLogin() async {
    // Get credential from local storage
    final _credentials = await _storage.readString('credentials').then(
      (encoded) {
        /// Decode base64 credentials.
        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        String decoded = stringToBase64.decode(encoded ?? '');
        // Return [email,password]
        return decoded.split(':');
      },
    );

    final _email = _credentials.elementAt(0);
    final _password = _credentials.elementAt(1);

    // Login
    UserModel? _user = await _auth.login(
      email: _email,
      password: _password,
    );

    // if user exist and status == 200 then save api to local storage.
    if (_user != null && _user.status == '200') {
      // Save backend token to local storage.
      await _storage.write('apiToken', stringValue: _user.token);

      // Set is Logged in
      await _storage.write('isLoggedIn', boolValue: true);

      return _user;
    } else {
      throw Exception('Silent Login Failed');
    }
  }

  void _onApiTokenExpired() async {
    try {
      // Try silent login
      final _user = await _apiSilentLogin();

      // if user exist and status ok then go to dashboard
      if (_user != null && _user.status == '200') {
        Get.off(
          () => DashboardScreen(
            fullName: _user.full_name,
            gender: _user.gender,
            photoUrl: _user.image,
          ),
          binding: DashboardBinding(),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Something Went Wrong",
        "Redirecting to dashboard",
        backgroundColor: primaryColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );

      Get.toNamed(AppPages.dashboard);
    }
  }

  void _onGoogleTokenExpired() async {
    try {
      // Get gooogle user
      final _googleUser = await _auth.googleAuth(silent: true);

      // Check google credential Suw.
      final _user = await _auth.verifyGoogleAccount(
        accessToken: _googleUser.accessToken ?? '',
        displayName: _googleUser.displayName ?? '',
      );

      if (_user!.status != '500') {
        // If user already registered, save api token to local storage.
        // If user google account valid, save google token to local storage.

        // Save google access token to local storage.
        await _storage.write('googleKey', stringValue: _googleUser.accessToken);

        // Save backend token to local storage.
        await _storage.write('apiToken', stringValue: _user.token);

        // Save google username to local storage
        await _storage.write(
          'googleFullName',
          stringValue: _googleUser.displayName,
        );

        // Save photo url to local storage
        await _storage.write(
          'googlePhotoUrl',
          stringValue: _googleUser.photoUrl ?? "",
        );

        final UserModel _appUser = await _auth.getUserData(token: _user.token!);

        // Set is Logged in
        await _storage.write('isLoggedIn', boolValue: true);

        // Go to dashboard
        Get.off(
          () => DashboardScreen(
            fullName: _googleUser.displayName,
            photoUrl: _googleUser.photoUrl,
            gender: _appUser.gender,
          ),
          binding: DashboardBinding(),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Session Expired",
        "Please Login Again",
        backgroundColor: warningColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
      Get.offAndToNamed(AppPages.dashboard);
    }
  }
}
