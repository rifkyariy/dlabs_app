import 'dart:convert';

import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:dlabs_apps/app/modules/dashboard/views/dashboard.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final AuthRepository _auth = Get.put(AuthRepository());
  final AppStorageService _storage = Get.find();

  late UserModel? _user;
  UserModel? get user => _user;

  late GoogleSignInAccount? _googleUser;
  GoogleSignInAccount? get googleUser => _googleUser;

  //Google Sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxString companyLogo = "".obs;

  // Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  RxBool isLoading = false.obs;
  RxBool isGoogleLoading = false.obs;

  // Message
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      _user = await _auth.login(email: email, password: password);
      return _user;
    } catch (e) {
      return _user;
    }
  }

  Future<String> register({
    required String email,
    required String password,
    required String fullname,
    required String identityNumber,
    required String phoneNumber,
    required String dateOfBirth,
    required String? gender,
    required String address,
    required String nationality,
  }) async {
    try {
      isLoading.value = true;
      _user = await _auth.register(
        email: email,
        password: password,
        fullname: fullname,
        identityNumber: identityNumber,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender ?? "",
        address: address,
        nationality: nationality,
      );
      isLoading.value = false;

      return "";
    } catch (e) {
      isLoading.value = false;
      String error = "$e";

      return error;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      final status = await _auth.forgotPassword(email: email);
      return status;
    } catch (e) {
      return false;
    }
  }

  void loginHandler() async {
    isLoading.value = true;
    bool isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool isPasswordLength = passwordController.text.length >= 8;
    bool isPasswordValid = passwordController.text != '';

    if (isEmailValid) {
      emailErrorMessage.value = '';

      if (isPasswordValid) {
        passwordErrorMessage.value = '';

        if (isPasswordLength) {
          // Login Handleer
          UserModel? _user = await login(
            email: emailController.text,
            password: passwordController.text,
          );

          if (_user != null && _user.status == '200') {
            isLoading.value = false;

            // Save backend token to local storage.
            await _storage.write('apiToken', stringValue: _user.token);

            // Set is Logged in
            await _storage.write('isLoggedIn', boolValue: true);

            // Write credential to local storage
            // encode to base64
            String credential =
                '${emailController.text}:${passwordController.text}';
            Codec<String, String> stringToBase64 = utf8.fuse(base64);
            String encoded = stringToBase64.encode(credential);

            await _storage.write('credentials', stringValue: encoded);

            // Go to dashboard
            Get.off(
              () => DashboardScreen(
                fullName: _user.full_name,
                photoUrl: _user.image,
                gender: _user.gender,
              ),
              binding: DashboardBinding(),
            );
          } else {
            isLoading.value = false;
            Get.snackbar(
              "Something Went Wrong",
              _user!.errors == "find user error"
                  ? "You don't have an account yet, Please sign up."
                  : "Invalid email or password",
              backgroundColor: primaryColor,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );
          }
        } else {
          isLoading.value = false;
          passwordErrorMessage.value =
              'Your password must be at least 8 characters.';
        }
      } else {
        isLoading.value = false;
        passwordErrorMessage.value = "Your password can't be blank.";
      }
    } else {
      isLoading.value = false;
      emailErrorMessage.value = 'Please enter a valid email address.';
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      // Login using google
      final _googleUser = await _auth.googleAuth(silent: false);

      // Check google credential Suw.
      final _user = await _auth.verifyGoogleAccount(
        accessToken: _googleUser.accessToken ?? '',
        displayName: _googleUser.displayName ?? '',
      );

      if (_user!.status != '500' && _user.isRegistered != 1) {
        isGoogleLoading.value = false;
        final _parameters = <String, String>{
          "fullName": _googleUser.displayName!,
          "email": _googleUser.email!,
          "password": _user.password ?? 'DirectLab123',
          "googlePhotoUrl": _googleUser.photoUrl ?? ''
        };

        Get.toNamed(AppPages.updatePersonalInfo, parameters: _parameters);
      } else {
        // If user already registered, save api token to local storage.
        // If user google account valid, save google token to local storage.

        // Save google access token to local storage.
        await _storage.write(
          'googleKey',
          stringValue: _googleUser.accessToken,
        );

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

        isGoogleLoading.value = false;

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
      isGoogleLoading.value = false;
      Get.snackbar(
        "Something Went Wrong",
        "Please try again later",
        backgroundColor: primaryColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() async {
    await _storage.readString('companyLogo').then((companyImage) {
      companyLogo.value = companyImage!;
    });

    super.onInit();
  }
}
