// ignore_for_file: file_names
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/signup/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              ),
              color: primaryColor,
              onPressed: () => Navigator.pop(context)),
          title: Text('', style: BoldTextStyle(blackColor)),
          centerTitle: true,
          actions: [],
          elevation: 0.0,
          backgroundColor: whiteColor,
          shadowColor: lightGreyColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeScalling().setHeight(20),
            left: SizeScalling().setWidth(24),
            right: SizeScalling().setWidth(24),
          ),
          child: Column(
            children: [
              // Logo and Header
              Obx(
                () => Center(
                    child: controller.companyLogo.value.isNotEmpty
                        ? Image.network(
                            controller.companyLogo.value,
                            width: SizeScalling().setWidth(100),
                            height: SizeScalling().setHeight(60),
                          )
                        : null),
              ),

              SizedBox(height: SizeScalling().setHeight(25)),

              // Google Login
              Center(
                child: ElevatedButton.icon(
                  icon: Image.asset(
                    'assets/image/logo-google-48dp.png',
                    width: SizeScalling().setWidth(20),
                    height: SizeScalling().setHeight(20),
                  ),
                  label: Text(
                    'register_google'.tr,
                    style: subtitleTextStyle(blackColor),
                  ),
                  onPressed: () =>
                      controller.signInController.handleGoogleSignIn(),
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

              SizedBox(height: SizeScalling().setHeight(16)),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                  Text(
                    'gen_or'.tr,
                    style: smallTextStyle(blackColor),
                  ),
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                ],
              ),

              SizedBox(height: SizeScalling().setHeight(16)),

              // Step Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'register_account_setup'.tr,
                    style: regularTextStyle(primaryColor),
                  ),
                  Text(
                    'register_first_step'.tr,
                    style: smallTextStyle(greyColor),
                  )
                ],
              ),
              Divider(color: greyColor),

              SizedBox(height: SizeScalling().setHeight(16)),

              // Full Name
              Obx(
                () => TextInput(
                  controller: controller.fullNameController,
                  label: 'gen_fullname'.tr,
                  name: 'gen_fullname'.tr,
                  errorMsg: controller.fullNameErrorMessage.value,
                ),
              ),

              // Email Address
              Obx(
                () => TextInput(
                  controller: controller.emailController,
                  label: 'gen_email'.tr,
                  name: "email",
                  placeholder: 'email_placeholder'.tr,
                  errorMsg: controller.emailErrorMessage.value,
                ),
              ),

              // Password
              Obx(
                () => TextInput(
                  controller: controller.passwordController,
                  label: 'gen_password'.tr,
                  name: "password",
                  type: "password",
                  errorMsg: controller.passwordErrorMessage.value,
                ),
              ),

              // Confirm Password
              Obx(
                () => TextInput(
                  controller: controller.confirmPasswordController,
                  label: "confirm_password".tr,
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
          () => AppButton(
            text: 'gen_next'.tr,
            textColor: whiteColor,
            onClicked: () => controller.signUpHandler(),
            isLoading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
