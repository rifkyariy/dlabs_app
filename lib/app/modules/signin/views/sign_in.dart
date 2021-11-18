import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final controller = Get.put<SignInController>(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 84.0, left: 24.0, right: 24.0),
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
            const SizedBox(height: 67),

            // Header Text
            Text(
              'Welcome to Direct Lab',
              textAlign: TextAlign.center,
              style: titleTextStyle(blackColor),
            ),

            const SizedBox(height: 8),

            Text(
              'Sign in to continue',
              textAlign: TextAlign.right,
              style: subtitleTextStyle(greyColor),
            ),

            const SizedBox(height: 44),

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
                    style: SmallTextStyle(primaryColor),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),

            const SizedBox(height: 10),

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

            // Google Button
            Center(
                child: ElevatedButton.icon(
              icon: Image.asset(
                'assets/image/logo-google-48dp.png',
                width: 20.5,
                height: 20.5,
              ),
              label: Text(
                'Sign In with Google',
                style: subtitleTextStyle(blackColor),
              ),
              onPressed: () => controller.handleGoogleSignIn(),
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
            )),
            const Spacer(),

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
    );
  }
}
