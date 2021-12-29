import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:dlabs_apps/app/global_widgets/app_google_button.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
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
              Center(
                child: Image.network(
                  'https://api-lims.kayabe.id/asset/uploads/setting/20211207041411LOGO KAYABE No Text.png',
                  width: SizeScalling().setWidth(100),
                  height: SizeScalling().setHeight(60),
                ),
                // child: Image.asset(
                //   'assets/image/logo-dlab.png',
                //   width: SizeScalling().setWidth(100),
                //   height: SizeScalling().setHeight(40),
                // ),
              ),
              SizedBox(height: SizeScalling().setHeight(40)),

              // Header Text
              Text(
                'Welcome to Direct Lab',
                textAlign: TextAlign.center,
                style: titleTextStyle(blackColor),
              ),

              SizedBox(height: SizeScalling().setHeight(8)),

              Text(
                'Sign in to continue',
                textAlign: TextAlign.right,
                style: subtitleTextStyle(greyColor),
              ),

              SizedBox(height: SizeScalling().setHeight(30)),

              // Regular Login
              // Email Input
              Obx(
                () => TextInput(
                  label: 'Email Address',
                  name: 'email',
                  placeholder: 'e.g. mail@address.com',
                  errorMsg: controller.emailErrorMessage.value,
                  controller: controller.emailController,
                ),
              ),

              // Password Input
              Obx(
                () => TextInput(
                  label: 'Password',
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
                      'Forgot Password ?',
                      style: smallTextStyle(primaryColor),
                    ),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),

              SizedBox(height: SizeScalling().setHeight(8)),

              // Sign In Button
              Obx(
                () => Button(
                  text: 'Sign In',
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
                    'Don’t have an account? ',
                    style: regularTextStyle(blackColor),
                  ),
                  TextButton(
                    child: Text(
                      'Sign Up',
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
