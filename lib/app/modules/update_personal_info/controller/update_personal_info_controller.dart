import 'dart:convert';

import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kayabe_lims/app/modules/dashboard/views/dashboard.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePersonalInfoController extends GetxController {
  SignInController signInController = Get.find();
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());
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
  RxString companyLogo = ''.obs;
  RxString genderValue = '1'.obs;

  RxList<Map<String, dynamic>>? nationalityList = <Map<String, dynamic>>[].obs;
  final RxString selectedNationalityString = ''.obs;

  // Reusable Function
  List<Map<String, dynamic>> convertIntoList(
      List keyName, List<Map<String, dynamic>> data) {
    var defaultKey = ["id", "value"];

    for (var item in data) {
      for (var i = 0; i < keyName.length; i++) {
        if (item.containsKey(keyName[i])) {
          var value = item[keyName[i]];
          item[defaultKey[i]] = "$value";
        }
      }
    }

    return data;
  }

  // Get List of Nationality
  Future<List<Map<String, dynamic>>> getListofNationality() async {
    var result = await _masterData.getNationalityList();
    var apiServiceKey = ["id", "nationality"];

    return convertIntoList(apiServiceKey, result);
  }

  void signUpHandler() async {
    if (idNumberController.text != '') {
      identityNumberErrorMessage.value = '';
      if (phoneNumberController.text != '') {
        phoneNumberErrorMessage.value = '';
        if (dateOfBirthController.text != '') {
          dateOfBirthErrorMessage.value = '';
          if (addressController.text != '') {
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
              nationality: "Indonesian",
            );
            if (status == "") {
              isLoading.value = false;

              // Save credentials to local storage
              String credential =
                  '${Get.parameters['email']!}:${Get.parameters['password']!}';
              Codec<String, String> stringToBase64 = utf8.fuse(base64);
              String encoded = stringToBase64.encode(credential);

              await _appStorageService.write(
                'credentials',
                stringValue: encoded,
              );

              Get.off(
                () => DashboardScreen(
                  fullName: Get.parameters['fullName'],
                  gender: genderValue.value,
                  photoUrl: Get.parameters['googlePhotoUrl'],
                ),
                binding: DashboardBinding(),
              );
            } else {
              isLoading.value = false;
              Get.snackbar(
                "Something Went Wrong",
                status,
                backgroundColor: primaryColor,
                colorText: whiteColor,
                snackPosition: SnackPosition.TOP,
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

  @override
  void onInit() async {
    await _appStorageService.readString('companyLogo').then((companyImage) {
      companyLogo.value = companyImage!;
    });

    selectedNationalityString.value = 'Indonesian';

    await getListofNationality()
        .then((result) => nationalityList!.value = result.toList());

    super.onInit();
  }
}
