import 'package:dlabs_apps/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:dlabs_apps/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:dlabs_apps/app/modules/forgot_password/views/forgot_password_screen.dart';
import 'package:dlabs_apps/app/modules/signin/bindings/signin_binding.dart';
import 'package:dlabs_apps/app/modules/signin/views/sign_in.dart';
import 'package:dlabs_apps/app/modules/signup/bindings/sign_up_binding.dart';
import 'package:dlabs_apps/app/modules/signup/views/sign_up_screen.dart';
import 'package:dlabs_apps/app/modules/update_personal_info/bindings/update_personal_info_binding.dart';
import 'package:dlabs_apps/app/modules/update_personal_info/views/update_personal_info_screen.dart';
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
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.signin,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),

    // GetPage(
    //   name: _Paths.resetPassword,
    //   page: () => ResetPasswordScreen(),
    // )

    GetPage(
      name: _Paths.updatePersonalInfo,
      page: () => const UpdatePersonalInfoScreen(),
      binding: UpdatePersonalInfoBinding(),
    )
  ];
}
