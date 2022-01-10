import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/modules/forgot_password/controller/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 84.0, left: 24.0, right: 24.0),
        child: SingleChildScrollView(
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
              SizedBox(height: 0.2 * MediaQuery.of(context).size.height),

              Align(
                alignment: Alignment.centerLeft,
                child: Text('Forgot Your Password?',
                    style: titleTextStyle(blackColor)),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No worries, you just need to type your email address and we will send the verification code.',
                  style: regularTextStyle(greyColor),
                ),
              ),
              const SizedBox(height: 24),

              // Email Address
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Email Input
                  Obx(
                    () => TextInput(
                      label: 'Email Address',
                      name: 'email',
                      placeholder: 'e.g. mail@address.com',
                      errorMsg: controller.emailErrorMessages.value,
                      controller: controller.emailController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Obx(
                () => AppButton(
                  text: 'Reset Password',
                  textColor: whiteColor,
                  onClicked: () => controller.forgotPasswordHandler(),
                  isLoading: controller.isLoading.value,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
