import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalBookingController extends GetxController {
  // Text Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // State
  RxBool isLoading = false.obs;
  RxString genderValue = '0'.obs;
  final currentSelectedValue = ''.obs;

  // Error Message
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString identityNumberErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;

  String? selectedDrowpdown = 'abc';
  List<String> dropdownTextList = ['abc', 'def', 'ghi'];
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
    },
  ];

  // Validation

  void signUpHandler() async {}
}
