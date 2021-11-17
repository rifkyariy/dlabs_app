import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/services/auth_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePersonalInfoController extends GetxController {
  AuthService repo = Get.find();
  SignInController signInController = Get.find();

  // Text Controller
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // State
  RxBool isLoading = false.obs;

  // Error Messages

  RxString identityNumberErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;

  RxString genderValue = '1'.obs;

  void signUpHandler() async {
    if (!GetUtils.isNull(idNumberController.text)) {
      identityNumberErrorMessage.value = '';
      if (!GetUtils.isNull(phoneNumberController.text)) {
        phoneNumberErrorMessage.value = '';
        if (!GetUtils.isNull(dateOfBirthController.text)) {
          dateOfBirthErrorMessage.value = '';
          if (!GetUtils.isNull(addressController.text)) {
            isLoading.value = true;
            final status = await signInController.register(
              email: Get.parameters['email']!,
              password: Get.parameters['password']!,
              fullname: Get.parameters['fullName']!,
              identityNumber: idNumberController.text,
              phoneNumber: phoneNumberController.text,
              dateOfBirth: dateOfBirthController.text,
              gender: genderValue.value,
              address: addressController.text,
            );
            if (status) {
              isLoading.value = false;
              Get.toNamed(AppPages.dashboard);
            } else {
              isLoading.value = false;
              Get.snackbar(
                "Error",
                "Register Failed",
                backgroundColor: dangerColor,
                colorText: whiteColor,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } else {
            addressErrorMessage.value = 'Address can\'t be blank';
          }
        } else {
          dateOfBirthErrorMessage.value = 'Date of birth can\'t be blank';
        }
      } else {
        phoneNumberErrorMessage.value = 'Please enter a valid phone number';
      }
    } else {
      identityNumberErrorMessage.value = 'Please enter a valid identity number';
    }
  }
}
