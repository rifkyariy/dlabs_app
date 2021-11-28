import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePersonalInfoController extends GetxController {
  SignInController signInController = Get.find();
  final AppStorageService _appStorageService = Get.find();

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
            final String status = await signInController.register(
              email: Get.parameters['email']!,
              password: Get.parameters['password']!,
              fullname: Get.parameters['fullName']!,
              identityNumber: idNumberController.text,
              phoneNumber: phoneNumberController.text,
              dateOfBirth: dateOfBirthController.text,
              gender: genderValue.value,
              address: addressController.text,
            );
            if (status == "") {
              isLoading.value = false;

              final _parameters = <String, String>{
                "fullName": Get.parameters['fullName']!,
                "gender": genderValue.value,
                "photoUrl": Get.parameters['googlePhotoUrl'] ?? '',
              };

              Get.offAndToNamed(AppPages.dashboard, parameters: _parameters);
            } else {
              isLoading.value = false;
              Get.snackbar(
                "Error",
                status,
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
