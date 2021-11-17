import 'package:dlabs_apps/app/modules/forgot_password/forgot_password.dart';
import 'package:dlabs_apps/app/modules/signin/views/sign_in.dart';
import 'package:dlabs_apps/app/modules/signup/sign_up.dart';
import 'package:dlabs_apps/app/modules/update_personal_info/update_personal_info.dart';
import 'package:dlabs_apps/app/modules/dashboard/views/dashboard.dart';
import 'package:dlabs_apps/app/modules/splash/views/splashscreen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const splash = Routes.splash;
  static const dashboard = Routes.dashboard;
  static const signin = Routes.signin;
  static const signup = Routes.signup;
  static const forgotPassword = Routes.forgotPassword;
  static const updatePersonalInfo = Routes.updatePersonalInfo;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => Dashboard(),
    ),
    GetPage(
      name: _Paths.signin,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => SignUp(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => ForgotPassword(),
    ),

    // GetPage(
    //   name: _Paths.resetPassword,
    //   page: () => ResetPasswordScreen(),
    // )

    GetPage(
      name: _Paths.updatePersonalInfo,
      page: () => const UpdatePersonalInfo(),
    )
  ];
}
