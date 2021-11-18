import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final SignInController _auth = Get.find();

  // Text Controller
  TextEditingController emailController = TextEditingController();

  // State
  // RxBool is Reactive Boolean (GetX properties), if the variable value changed, all of OBX (Observer Widget)
  // that use this variable will be rebuilt based on current value.
  RxBool isLoading = false.obs;

  // Error Messages
  RxString emailErrorMessages = ''.obs;

  void forgotPasswordHandler() async {
    bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(emailController.text);

    if (isEmailValid) {
      emailErrorMessages.value = '';

      // Change state to loading
      isLoading.value = true;
      final status = await _auth.forgotPassword(email: emailController.text);

      if (status) {
        isLoading.value = false;
        emailController.text = '';
        Get.snackbar(
          'Success',
          'Please check verification code on your email.',
          backgroundColor: Colors.lightGreen,
          colorText: whiteColor,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        isLoading.value = false;
        emailController.text = '';
        Get.snackbar(
          'Error',
          'User not found',
          backgroundColor: dangerColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      emailErrorMessages.value = 'Please enter a valid email address.';
    }
  }
}
