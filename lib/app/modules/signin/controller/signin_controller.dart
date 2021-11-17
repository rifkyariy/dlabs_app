import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/services/auth_service.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthService repo = Get.put(AuthService());

  late UserModel? _user;
  UserModel? get user => _user;

  // Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State
  RxBool isLoading = false.obs;

  // Message
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;

  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      _user = await repo.login(email: email, password: password);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> register({
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
      _user = await repo.register(
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
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      isLoading.value = true;
      return await repo
          .forgotPassword(email: email)
          .then((value) => isLoading.value = false);
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  void loginHandler() async {
    bool isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool isPasswordValid = passwordController.text != '';

    if (isEmailValid) {
      emailErrorMessage.value = '';

      if (isPasswordValid) {
        passwordErrorMessage.value = '';
        if (await login(
          email: emailController.text,
          password: passwordController.text,
        )) {
          Get.toNamed(AppPages.dashboard);
        } else {
          Get.snackbar(
            "Error",
            "Invalid Email or Password",
            backgroundColor: dangerColor,
            colorText: whiteColor,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        passwordErrorMessage.value = "Password can't be blank.";
      }
    } else {
      emailErrorMessage.value = 'Please enter a valid email address.';
    }
  }
}
