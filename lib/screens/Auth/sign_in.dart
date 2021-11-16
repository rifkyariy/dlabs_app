import 'package:dlabs_apps/components/button_loading.dart';
import 'package:dlabs_apps/components/text_input.dart';
import 'package:dlabs_apps/providers/auth_provider.dart';
import 'package:dlabs_apps/theme.dart';
import 'package:dlabs_apps/components/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  String emailError = "";
  String passError = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text);
      bool passwordValid = passwordController.text != "";

      print("email valid $emailValid");

      if (emailValid) {
        setState(() {
          emailError = "";
        });

        if (passwordValid) {
          setState(() {
            passError = "";
            isLoading = true;
          });

          if (await authProvider.login(
              email: emailController.text, password: passwordController.text)) {
            Navigator.pushNamed(context, '/home');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: dangerColor,
                content: Text(
                  "You don't have an account yet, please sign up",
                  textAlign: TextAlign.center,
                  style: subtitleTextStyle(whiteColor),
                )));
          }

          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            passError = "Password can't be blank.";
          });
        }
      } else {
        setState(() {
          emailError = "Please enter a valid email address.";
        });
      }
    }

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
            SizedBox(height: 67),

            // Header Text
            Text(
              'Welcome to Direct Lab',
              textAlign: TextAlign.center,
              style: titleTextStyle(blackColor),
            ),
            SizedBox(height: 8),
            Text(
              'Sign in to continue',
              textAlign: TextAlign.right,
              style: subtitleTextStyle(greyColor),
            ),
            SizedBox(height: 44),

            // Regular Login
            // Email Input
            TextInput(
                label: 'Email Address',
                name: 'email',
                placeholder: 'e.g. mail@address.com',
                errorMsg: emailError,
                controller: emailController),
            // Password Input
            TextInput(
                label: 'Password',
                name: 'password',
                errorMsg: passError,
                type: 'password',
                controller: passwordController),

            // Forgot Password
            Row(
              children: [
                TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forgot-password'),
                    child: Text('Forgot Password ?',
                        style: SmallTextStyle(primaryColor)))
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            SizedBox(
              height: 10,
            ),

            // Sign In Button
            isLoading
                ? LoadingButton(
                    text: 'Sign In',
                    textColor: whiteColor,
                    onClicked: () {},
                  )
                : Button(
                    text: 'Sign In',
                    textColor: whiteColor,
                    onClicked: handleLogin,
                  ),
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
            Spacer(),

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
                  onPressed: () => Navigator.pushNamed(context, '/sign-up'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
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
