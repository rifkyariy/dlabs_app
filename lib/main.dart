import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:dlabs_apps/providers/auth_provider.dart';
import 'package:dlabs_apps/app/modules/forgot_password/forgot_password.dart';
import 'package:dlabs_apps/app/modules/signin/views/sign_in.dart';
import 'package:dlabs_apps/app/modules/signup/views/sign_up_screen.dart';
import 'package:dlabs_apps/app/modules/update_personal_info/views/update_personal_info_screen.dart';
import 'package:dlabs_apps/app/modules/dashboard/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: AppPages.signin,
      ),
    );
  }
}
