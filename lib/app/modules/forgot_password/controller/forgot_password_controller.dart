import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';

class ForgotPasswordController extends GetxController {
  final SignInController _auth = Get.find();
  final AppStorageService _storage = Get.find();

  // Text Controller
  TextEditingController emailController = TextEditingController();
  RxString companyLogo = "".obs;

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

        // Redirect into sign in page
        Get.toNamed(AppPages.signin);

        // Display success snackbar
        Get.snackbar(
          'Success',
          'Please check verification code on your email.',
          backgroundColor: Colors.lightGreen,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        isLoading.value = false;
        emailController.text = '';

        // Display error snackbar
        Get.snackbar(
          'Something Went Wrong',
          'User not found',
          backgroundColor: primaryColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      emailErrorMessages.value = 'Please enter a valid email address.';
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await _storage.readString('companyLogo').then((companyImage) {
      companyLogo.value = companyImage!;
    });
  }
}
