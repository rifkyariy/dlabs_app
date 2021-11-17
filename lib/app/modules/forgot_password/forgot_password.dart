import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/button_loading.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/providers/auth_provider.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController(text: '');
  String emailError = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleForgotPassword() async {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text);

      if (emailValid) {
        setState(() {
          emailError = "";
          isLoading = true;
        });

        if (await authProvider.forgotPassword(email: emailController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                'Please check verification code on your email.',
                textAlign: TextAlign.center,
                style: subtitleTextStyle(whiteColor),
              )));
          Navigator.pushNamed(context, '/sign-in');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: dangerColor,
              content: Text(
                'User not found',
                textAlign: TextAlign.center,
                style: subtitleTextStyle(whiteColor),
              )));
        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          emailError = "Please enter a valid email address.";
        });
      }
    }

    return Scaffold(
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
            SizedBox(height: 0.2 * MediaQuery.of(context).size.height),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot Your Password?',
                  style: titleTextStyle(blackColor)),
            ),
            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'No worries, you just need to type your email address and we will send the verification code.',
                style: regularTextStyle(greyColor),
              ),
            ),
            SizedBox(height: 24),

            // Email Address
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Email Input
                TextInput(
                    label: 'Email Address',
                    name: 'email',
                    placeholder: 'e.g. mail@address.com',
                    errorMsg: emailError,
                    controller: emailController),
              ],
            ),

            SizedBox(
              height: 24,
            ),

            isLoading
                ? LoadingButton(
                    text: 'Reset Password',
                    textColor: whiteColor,
                    onClicked: () {},
                  )
                : Button(
                    text: 'Reset Password',
                    textColor: whiteColor,
                    onClicked: handleForgotPassword,
                  ),

            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
