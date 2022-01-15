import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/user_model.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AppStorageService _storage = Get.find();
  final AuthRepository _auth = Get.find();

  late RxString fullname = ''.obs;
  late RxString gender = ''.obs;
  late RxString photoUrl = ''.obs;
  late RxBool isLoggedIn = false.obs;
  late RxString googleToken = ''.obs;
  late RxString apiToken = ''.obs;

  @override
  void onInit() async {
    final _apiToken = await _storage.readString('apiToken');

    final user = await _auth.getUserData(token: _apiToken ?? '');
    gender.value = user.gender ?? '0';

    var googleKey = await _storage.readString('googleKey');
    if (await _storage.readString('googleKey') != "") {
      photoUrl.value = await _storage.readString('googlePhotoUrl') ?? '';
      fullname.value = await _storage.readString('googleFullName') ?? '';
    } else {
      fullname.value = user.full_name ?? '';
      photoUrl.value = user.image ?? '';
    }

    isLoggedIn.value = await _storage.readBool('isLoggedIn') ?? false;
    apiToken.value = _apiToken ?? '';

    print("auth status : $isLoggedIn , $apiToken");
    super.onInit();
  }

  void handleLogout() async {
    // Clear Local Rx Value
    fullname.value = '';
    gender.value = '';
    photoUrl.value = '';
    isLoggedIn.value = false;
    apiToken.value = '';
    googleToken.value = '';

    // Logout Google
    final googlesigin = GoogleSignIn();
    googlesigin.signOut();

    // Remove Shared Preference
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('googleKey');
    sp.remove('apiToken');
    sp.remove('googleFullName');
    sp.remove('googlePhotoUrl');
    sp.remove('credentials');

    // Redirect into sign in pages
    Get.toNamed(AppPages.signin);
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
      isLoggedIn.value = true;

      return _user;
    } else {
      throw Exception('Silent Login Failed');
    }
  }

  void onApiTokenExpired() async {
    try {
      // Try silent login
      final _user = await _apiSilentLogin();

      // if user exist and status ok then go to dashboard
      if (_user != null && _user.status == '200') {
        // Set Auth RxString
        isLoggedIn.value = true;
        fullname.value = _user.full_name!;
        photoUrl.value = _user.image!;
        gender.value = _user.gender!;
        googleToken.value = "";
        apiToken.value = _user.token!;

        // Go to dashboard
        Get.offAndToNamed(AppPages.dashboard);
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

  void onGoogleTokenExpired() async {
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

        // Set Auth RxString
        isLoggedIn.value = true;
        fullname.value = _googleUser.displayName!;
        photoUrl.value = _googleUser.photoUrl!;
        gender.value = _appUser.gender!;
        googleToken.value = _googleUser.accessToken!;
        apiToken.value = _user.token!;

        // Go to dashboard
        Get.offAndToNamed(AppPages.dashboard);
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
