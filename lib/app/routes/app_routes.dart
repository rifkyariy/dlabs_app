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

  static const personalTransactionDetail = _Paths.personalTransactionDetail;
  static const organizationTransactionDetail =
      _Paths.organizationTransactionDetail;
  static const transactionPatientList = _Paths.transactionPatientList;
  static const personalTransactionPatientInformation =
      _Paths.personalTransactionPatientInformation;
  static const medicalQuestionnaireList = _Paths.medicalQuestionnaireList;
  static const invoice = _Paths.invoice;
  static const trackingProcess = _Paths.trackingProcess;
  static const medicalHistory = _Paths.medicalHistory;

  static const personalPayment = _Paths.personalPayment;
  static const organizationPayment = _Paths.organizationPayment;
  static const paymentOffline = _Paths.paymentOffline;
  static const paymentCash = _Paths.paymentCash;
  static const aboutUs = _Paths.aboutUs;
  static const services = _Paths.services;
  static const changePassword = _Paths.changePassword;
  static const personalInformation = _Paths.personalInformation;
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

  static const personalBooking = '/booking-personal';
  static const questionnaire = '/booking-personal-questionnaire';
  static const organizationBooking = '/booking-organization';
  static const transactionHistory = '/transaction-history';

  static const personalTransactionDetail = '/transaction-personal-detail';
  static const organizationTransactionDetail =
      '/transaction-organization-detail';
  static const transactionPatientList = '/transaction-patient-list';
  static const personalTransactionPatientInformation =
      '/transaction-personal-patient-information';
  static const medicalQuestionnaireList = '/transaction-medical-questionnaire';
  static const invoice = '/transaction-invoice';
  static const trackingProcess = '/transaction-tracking-process';
  static const medicalHistory = '/transaction-medical-history';

  static const personalPayment = '/payment-personal';
  static const organizationPayment = '/payment-organization';

  static const paymentOffline = '/payment-offline';
  static const paymentCash = '/payment-cash';

  static const aboutUs = '/profile/about';
  static const services = '/profile/services';

  static const changePassword = '/profile/change-password';
  static const personalInformation = '/profile/personal-info';
}
