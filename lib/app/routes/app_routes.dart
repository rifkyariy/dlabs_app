part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const dashboard = _Paths.dashboard;
  static const splash = _Paths.splash;
  static const signin = _Paths.signin;
  static const signup = _Paths.signup;
  static const resetPassword = _Paths.resetPassword;
  static const forgotPassword = _Paths.forgotPassword;
  static const updatePersonalInfo = _Paths.updatePersonalInfo;
  static const personalBooking = _Paths.personalBooking;
  static const questionnaire = _Paths.questionnaire;
  static const organizationBooking = _Paths.organizationBooking;
  static const transactionHistory = _Paths.transactionHistory;
  static const profile = _Paths.profile;
}

abstract class _Paths {
  static const dashboard = '/dashboard';
  static const splash = '/splash';
  static const signin = '/signin';
  static const signup = '/signup';
  static const resetPassword = '/reset-password';
  static const forgotPassword = '/forgot-password';
  static const updatePersonalInfo = '/update-personal-info';
  static const profile = '/profile';

  static const personalBooking = '/booking/personal';
  static const questionnaire = '/booking/personal/questionnaire';
  static const organizationBooking = '/booking/organization';
  static const transactionHistory = '/transaction/history';
}
