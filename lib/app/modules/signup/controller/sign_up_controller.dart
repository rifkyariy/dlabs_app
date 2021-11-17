import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Text Controllers

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // State
  RxBool isLoading = false.obs;

  // Error Message
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;
  RxString passwordConfirmErrorMessage = ''.obs;

  // Validation

  void signUpHandler() async {
    bool isFullNameValid = fullNameController.text != '';
    bool isPasswordValid = passwordController.text != '';
    bool isPasswordLengthValid = passwordController.text.length >= 8;
    bool isConfirmPasswordValid = confirmPasswordController.text != '' &&
        passwordController.text == confirmPasswordController.text;
    bool isEmailValid = GetUtils.isEmail(emailController.text);

    if (isFullNameValid) {
      fullNameErrorMessage.value = '';
      if (isEmailValid) {
        emailErrorMessage.value = '';
        if (isPasswordValid) {
          passwordErrorMessage.value = '';
          if (isPasswordLengthValid) {
            passwordErrorMessage.value = '';
            if (isConfirmPasswordValid) {
              passwordConfirmErrorMessage.value = '';
              var _parameters = <String, String>{
                "fullName": fullNameController.text,
                "email": emailController.text,
                "password": passwordController.text,
              };
              Get.toNamed(AppPages.updatePersonalInfo, parameters: _parameters);
            } else {
              passwordErrorMessage.value =
                  'Confirmation password doesn\'t match';
            }
          } else {
            passwordErrorMessage.value =
                'Password must be at least 8 characther';
          }
        } else {
          passwordErrorMessage.value = 'Password can\'t be blank';
        }
      } else {
        emailErrorMessage.value = 'Please enter a valid email address.';
      }
    } else {
      fullNameErrorMessage.value = 'Full Name can\'t be blank.';
    }
  }
}
