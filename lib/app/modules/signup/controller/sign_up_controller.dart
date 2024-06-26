import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final SignInController signInController = Get.find();
  final AppStorageService _storage = Get.find();

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
  RxString companyLogo = "".obs;

  // Validation

  void signUpHandler() async {
    bool isFullNameValid = fullNameController.text != '';
    bool isFullNameLengthValid = fullNameController.text.length >= 6;
    bool isPasswordValid = passwordController.text != '';
    bool isPasswordLengthValid = passwordController.text.length >= 8;
    bool isConfirmPasswordValid = confirmPasswordController.text != '' &&
        passwordController.text == confirmPasswordController.text;
    bool isEmailValid = GetUtils.isEmail(emailController.text);

    if (isFullNameValid) {
      fullNameErrorMessage.value = '';
      if (isFullNameLengthValid) {
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
                Get.toNamed(
                  AppPages.updatePersonalInfo,
                  parameters: _parameters,
                );
              } else {
                passwordConfirmErrorMessage.value =
                    'Confirmation password doesn\'t match.';
              }
            } else {
              passwordErrorMessage.value =
                  'Your password must be at least 8 characters.';
            }
          } else {
            passwordErrorMessage.value = 'Your password can\'t be blank.';
          }
        } else {
          emailErrorMessage.value = 'Please enter a valid email address.';
        }
      } else {
        fullNameErrorMessage.value =
            'Your full name must be at least 6 characters.';
      }
    } else {
      fullNameErrorMessage.value = 'Your full name can\'t be blank.';
    }
  }

  @override
  void onInit() async {
    await _storage.readString('companyLogo').then((companyImage) {
      companyLogo.value = companyImage!;
    });

    super.onInit();
  }
}
