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
}

abstract class _Paths {
  static const dashboard = '/dashboard';
  static const splash = '/splash';
  static const signin = '/signin';
  static const signup = '/signup';
  static const resetPassword = '/reset-password';
  static const forgotPassword = '/forgot-password';
  static const updatePersonalInfo = '/update-personal-info';
}
