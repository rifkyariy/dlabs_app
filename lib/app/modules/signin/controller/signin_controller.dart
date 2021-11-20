import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_service.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final AuthService _auth = Get.put(AuthService());

  late UserModel? _user;
  UserModel? get user => _user;

  //Google Sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  RxBool isLoading = false.obs;

  // Message
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;

  Future<String> login(
      {required String email, required String password}) async {
    isLoading.value = true;
    try {
      _user = await _auth.login(email: email, password: password);
      isLoading.value = false;
      return "";
    } catch (e) {
      isLoading.value = false;

      String error = "$e";

      print("error : $e");
      return error;
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

      print("error : $e");
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
          String status = await login(
              email: emailController.text, password: passwordController.text);
          print(status);
          if (status == "") {
            Get.toNamed(AppPages.dashboard);
          } else {
            Get.snackbar(
              "Error",
              status == "find user error"
                  ? "You don't have an account yet, Please sign up."
                  : "Invalid email or password",
              backgroundColor: dangerColor,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );
          }
        } else {
          passwordErrorMessage.value =
              'Your password must be at least 8 characters.';
        }
      } else {
        passwordErrorMessage.value = "Your password can't be blank.";
      }
    } else {
      emailErrorMessage.value = 'Please enter a valid email address.';
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      final _user = await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
