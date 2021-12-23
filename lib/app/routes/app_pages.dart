import 'package:dlabs_apps/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:dlabs_apps/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:dlabs_apps/app/modules/forgot_password/views/forgot_password_screen.dart';
import 'package:dlabs_apps/app/modules/organization_booking/bindings/organization_booking_binding.dart';
import 'package:dlabs_apps/app/modules/organization_booking/views/organization_booking.dart';
import 'package:dlabs_apps/app/modules/personal_booking/bindings/personal_booking_binding.dart';
import 'package:dlabs_apps/app/modules/personal_booking/views/personal_booking.dart';
import 'package:dlabs_apps/app/modules/personal_booking/views/questionnaire.dart';

import 'package:dlabs_apps/app/modules/signin/bindings/signin_binding.dart';
import 'package:dlabs_apps/app/modules/signin/views/sign_in.dart';
import 'package:dlabs_apps/app/modules/signup/bindings/sign_up_binding.dart';
import 'package:dlabs_apps/app/modules/signup/views/sign_up_screen.dart';
import 'package:dlabs_apps/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:dlabs_apps/app/modules/transaction/views/organization_transaction_detail/organization_transaction_detail_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/personal_transaction_detail/personal_transaction_detail_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/personal_transaction_detail/personal_transaction_patient_information_view.dart';
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
  static const personalBooking = Routes.personalBooking;
  static const questionnaire = Routes.questionnaire;
  static const organizationBooking = Routes.organizationBooking;
  static const transactionHistory = Routes.transactionHistory;

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
    ),

    GetPage(
      name: _Paths.personalBooking,
      page: () => PersonalBooking(),
      binding: PersonalBookingBinding(),
    ),

    GetPage(
      name: _Paths.questionnaire,
      page: () => Questionnaire(),
      binding: PersonalBookingBinding(),
    ),

    GetPage(
      name: _Paths.organizationBooking,
      page: () => OrganizationBooking(),
      binding: OrganizationBookingBinding(),
    ),

    GetPage(
      name: _Paths.transactionHistory,
      page: () => OrganizationTransactionDetailView(),
      binding: TransactionHistoryViewBinding(),
    ),
  ];
}
