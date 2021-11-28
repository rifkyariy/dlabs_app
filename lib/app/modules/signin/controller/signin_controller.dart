import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
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

            final _parameters = <String, String>{
              "fullName": _user.full_name ?? '',
              "photoUrl": _user.image ?? '',
              "userGender": _user.gender ?? '0',
            };

            // Go to dashboard
            Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);
          } else {
            isLoading.value = false;
            Get.snackbar(
              "Error",
              _user!.errors == "find user error"
                  ? "You don't have an account yet, Please sign up."
                  : "Invalid email or password",
              backgroundColor: dangerColor,
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
      // sign out
      _googleSignIn.signOut();
      isGoogleLoading.value = true;
      final GoogleSignInAccount? _googleUser =
          await _googleSignIn.signIn().then(
        (result) {
          result!.authentication.then(
            (googleKey) async {
              // Check google access token in backend
              final _user = await _auth.verifyGoogleAccount(
                accessToken: googleKey.accessToken!,
                displayName: _googleSignIn.currentUser!.displayName!,
              );

              // If User is not registered then go to update personal info with parameters

              if (_user!.status != '500' && _user.isRegistered != 1) {
                isGoogleLoading.value = false;
                final _parameters = <String, String>{
                  "fullName": _googleSignIn.currentUser!.displayName!,
                  "email": _googleSignIn.currentUser!.email,
                  "password": _user.password ?? 'DirectLab123',
                };

                Get.toNamed(
                  AppPages.updatePersonalInfo,
                  parameters: _parameters,
                );
              } else {
                // If user already registered, save api token to local storage.
                // If user google account valid, save google token to local storage.

                // Save google access token to local storage.
                await _storage.write(
                  'googleKey',
                  stringValue: googleKey.accessToken,
                );

                // Save backend token to local storage.
                await _storage.write('apiToken', stringValue: _user.token);

                // Save google username to local storage
                await _storage.write(
                  'googleFullName',
                  stringValue: _googleSignIn.currentUser!.displayName,
                );

                // Save photo url to local storage
                await _storage.write(
                  'googlePhotoUrl',
                  stringValue: _googleSignIn.currentUser!.photoUrl ?? "",
                );

                final UserModel _appUser = await _auth.getUserData(
                  token: _user.token!,
                );

                final _parameters = <String, String>{
                  "fullName": _googleSignIn.currentUser!.displayName!,
                  "photoUrl": _googleSignIn.currentUser!.photoUrl ?? "",
                  "gender": _appUser.gender ?? '1',
                };

                // Set is Logged in
                await _storage.write('isLoggedIn', boolValue: true);

                isGoogleLoading.value = false;
                // Go to dashboard
                Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);
              }
            },
          );
        },
      );

      //
      this._googleUser = _googleUser;
    } catch (e) {
      isGoogleLoading.value = false;
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
