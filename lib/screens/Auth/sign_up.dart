// ignore_for_file: file_names
import 'dart:convert';

import 'package:dlabs_apps/components/navbar.dart';
import 'package:dlabs_apps/components/text_input.dart';
import 'package:dlabs_apps/theme.dart';
import 'package:dlabs_apps/Components/input_field.dart';
import 'package:dlabs_apps/Components/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullnameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  String fullnameError = "";
  String emailError = "";
  String passwordError = "";
  String passwordConfirmError = "";

  @override
  Widget build(BuildContext context) {
    _saveData() async {
      String fullname = fullnameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String confirmPassword = confirmPasswordController.text;

      bool fullnameValid = fullname != "";
      bool passwordValid = password != "";
      bool confirmPasswordValid =
          confirmPassword != "" && password == confirmPassword;
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text);

      if (fullnameValid) {
        setState(() {
          fullnameError = "";
        });

        if (emailValid) {
          setState(() {
            emailError = "";
          });

          if (passwordValid) {
            setState(() {
              passwordError = "";
            });

            if (confirmPasswordValid) {
              setState(() {
                passwordConfirmError = "";
              });

              print(fullname);
              print(email);
              print(password);

              SharedPreferences savePref =
                  await SharedPreferences.getInstance();

              savePref.setString("fullname", fullname);
              savePref.setString("email", email);
              savePref.setString("password", password);

              Navigator.pushNamed(context, '/update-personal-info');
            } else {
              setState(() {
                passwordConfirmError = "Confirmation password doesn't match.";
              });
            }
          } else {
            setState(() {
              passwordError = "Password can't be blank.";
            });
          }
        } else {
          setState(() {
            emailError = "Pleas enter a valid email address.";
          });
        }
      } else {
        setState(() {
          fullnameError = "Fullname can't be blank.";
        });
      }

      print(fullnameError);
    }

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
                SizedBox(height: 40),

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
                  onPressed: () {
                    print('Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    elevation: 0,
                    minimumSize: Size(double.infinity, 46),
                    shape: new RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: lightGreyColor,
                      ),
                      borderRadius: new BorderRadius.circular(4.8),
                    ),
                  ),
                )),
                SizedBox(
                  height: 16,
                ),

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
                SizedBox(
                  height: 16,
                ),

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
                SizedBox(
                  height: 16,
                ),

                // Full Name
                TextInput(
                  controller: fullnameController,
                  label: "Full Name",
                  name: "fullname",
                  errorMsg: fullnameError,
                ),

                // Email Address
                TextInput(
                    controller: emailController,
                    label: "Email Address",
                    name: "email",
                    placeholder: 'e.g. mail@address.com',
                    errorMsg: emailError),

                // Password
                TextInput(
                    controller: passwordController,
                    label: "Password",
                    name: "password",
                    type: "password",
                    errorMsg: passwordError),

                // Confirm Password
                TextInput(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    name: "password",
                    type: "password",
                    errorMsg: passwordConfirmError),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
              top: 12, bottom: 24.0, left: 24.0, right: 24.0),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: lightGreyColor, width: 1))),
          child:
              // Submit Button
              Button(
                  text: 'Next',
                  textColor: whiteColor,
                  onClicked: () {
                    _saveData();
                  }),
        ));
  }
}
