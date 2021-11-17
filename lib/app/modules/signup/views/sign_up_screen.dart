// ignore_for_file: file_names

import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/signup/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 96.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              // Logo and Header
              Center(
                child: Image.asset(
                  'assets/image/logo-dlab.png',
                  width: 102,
                  height: 43,
                ),
              ),

              const SizedBox(height: 40),

              // Google Login
              Center(
                child: ElevatedButton.icon(
                  icon: Image.asset(
                    'assets/image/logo-google-48dp.png',
                    width: 20.5,
                    height: 20.5,
                  ),
                  label: Text(
                    'Sign Up with Google',
                    style: subtitleTextStyle(blackColor),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 46),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: lightGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(4.8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                  Text(
                    'or',
                    style: SmallTextStyle(blackColor),
                  ),
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Step Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Setup',
                    style: regularTextStyle(primaryColor),
                  ),
                  Text(
                    'Step 1 of 2',
                    style: SmallTextStyle(greyColor),
                  )
                ],
              ),
              Divider(color: greyColor),

              const SizedBox(height: 16),

              // Full Name
              Obx(
                () => TextInput(
                  controller: controller.fullNameController,
                  label: "Full Name",
                  name: "fullname",
                  errorMsg: controller.fullNameErrorMessage.value,
                ),
              ),

              // Email Address
              Obx(
                () => TextInput(
                  controller: controller.emailController,
                  label: "Email Address",
                  name: "email",
                  placeholder: 'e.g. mail@address.com',
                  errorMsg: controller.emailErrorMessage.value,
                ),
              ),

              // Password
              Obx(
                () => TextInput(
                  controller: controller.passwordController,
                  label: "Password",
                  name: "password",
                  type: "password",
                  errorMsg: controller.passwordErrorMessage.value,
                ),
              ),

              // Confirm Password
              Obx(
                () => TextInput(
                  controller: controller.confirmPasswordController,
                  label: "Confirm Password",
                  name: "password",
                  type: "password",
                  errorMsg: controller.passwordConfirmErrorMessage.value,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
            top: 12, bottom: 24.0, left: 24.0, right: 24.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: lightGreyColor, width: 1),
          ),
        ),
        // Submit Button
        child: Obx(
          () => Button(
            text: 'Next',
            textColor: whiteColor,
            onClicked: () => controller.signUpHandler(),
            isLoading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
