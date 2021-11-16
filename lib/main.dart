// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
// import 'package:dlabs_apps/screens/Auth/forgot_password.dart';
import 'package:dlabs_apps/providers/auth_provider.dart';
import 'package:dlabs_apps/screens/Auth/forgot_password.dart';
import 'package:dlabs_apps/screens/Auth/sign_in.dart';
import 'package:dlabs_apps/screens/Auth/reset_password.dart';
import 'package:dlabs_apps/screens/Auth/sign_up.dart';
import 'package:dlabs_apps/screens/Auth/update_personal_info.dart';
import 'package:dlabs_apps/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SignIn(),
            '/home': (context) => Dashboard(),
            '/sign-in': (context) => SignIn(),
            '/forgot-password': (context) => ForgotPassword(),
            '/sign-up': (context) => SignUp(),
            '/update-personal-info': (context) => UpdatePersonalInfo(),
          },
        ),
      ),
    );
  }
}
