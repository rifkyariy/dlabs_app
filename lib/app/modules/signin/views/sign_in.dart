import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_google_button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              ),
              color: primaryColor,
              onPressed: () => Navigator.pop(context, true)),
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
            left: SizeScalling().setHeight(24),
            right: SizeScalling().setHeight(24),
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

              // Header Text
              Text(
                'gen_welcome'.tr,
                textAlign: TextAlign.center,
                style: titleTextStyle(blackColor),
              ),

              SizedBox(height: SizeScalling().setHeight(8)),

              Text(
                'pop_login_required'.tr,
                textAlign: TextAlign.right,
                style: subtitleTextStyle(greyColor),
              ),

              SizedBox(height: SizeScalling().setHeight(30)),

              // Regular Login
              // Email Input
              Obx(
                () => TextInput(
                  label: 'gen_email'.tr,
                  name: 'email',
                  placeholder: 'email_placeholder'.tr,
                  errorMsg: controller.emailErrorMessage.value,
                  controller: controller.emailController,
                ),
              ),

              // Password Input
              Obx(
                () => TextInput(
                  label: 'gen_password'.tr,
                  name: 'password',
                  errorMsg: controller.passwordErrorMessage.value,
                  type: 'password',
                  controller: controller.passwordController,
                ),
              ),

              // Forgot Password
              Row(
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(AppPages.forgotPassword),
                    child: Text(
                      'gen_forgot_password'.tr,
                      style: smallTextStyle(primaryColor),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),

              SizedBox(height: SizeScalling().setHeight(8)),

              // Sign In Button
              Obx(
                () => AppButton(
                  text: 'login'.tr,
                  textColor: whiteColor,
                  onClicked: () {
                    controller.loginHandler();
                  },
                  isLoading: controller.isLoading.value,
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
                    'or',
                    style: smallTextStyle(blackColor),
                  ),
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                ],
              ),
              SizedBox(height: SizeScalling().setHeight(16)),

              // Google Button
              Obx(
                () => AppGoogleButton(
                  onPressed: () async => controller.handleGoogleSignIn(),
                  isLoading: controller.isGoogleLoading.value,
                ),
              ),
              const SizedBox(height: 16),

              // Sign Up
              Row(
                children: [
                  Text(
                    'dont_have_account'.tr,
                    style: regularTextStyle(blackColor),
                  ),
                  TextButton(
                    child: Text(
                      'signup'.tr,
                      style: regularTextStyle(dangerColor),
                    ),
                    onPressed: () => Get.toNamed(AppPages.signup),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
