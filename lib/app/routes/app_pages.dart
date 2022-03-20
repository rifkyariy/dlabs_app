import 'package:kayabe_lims/app/modules/article/views/article_home_view.dart';
import 'package:kayabe_lims/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kayabe_lims/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:kayabe_lims/app/modules/forgot_password/views/forgot_password_screen.dart';
import 'package:kayabe_lims/app/modules/organization_booking/bindings/organization_booking_binding.dart';
import 'package:kayabe_lims/app/modules/organization_booking/views/organization_booking.dart';
import 'package:kayabe_lims/app/modules/personal_booking/bindings/personal_booking_binding.dart';
import 'package:kayabe_lims/app/modules/personal_booking/views/personal_booking.dart';
import 'package:kayabe_lims/app/modules/personal_booking/views/questionnaire.dart';
import 'package:kayabe_lims/app/modules/profile/bindings/profile_view_binding.dart';
import 'package:kayabe_lims/app/modules/profile/view/about_view.dart';
import 'package:kayabe_lims/app/modules/profile/view/help_center_view.dart';
import 'package:kayabe_lims/app/modules/profile/view/change_password_view.dart';
import 'package:kayabe_lims/app/modules/profile/view/personal_information_view.dart';
import 'package:kayabe_lims/app/modules/profile/view/profile_view.dart';
import 'package:kayabe_lims/app/modules/profile/view/service_view.dart';

import 'package:kayabe_lims/app/modules/signin/bindings/signin_binding.dart';
import 'package:kayabe_lims/app/modules/signin/views/sign_in.dart';
import 'package:kayabe_lims/app/modules/signup/bindings/sign_up_binding.dart';
import 'package:kayabe_lims/app/modules/signup/views/sign_up_screen.dart';
import 'package:kayabe_lims/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:kayabe_lims/app/modules/transaction/views/invoice_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/medical_history_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/medical_questionnarie_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/organization_transaction_detail/organization_transaction_detail_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/patient_list_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/organization_payment_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/payment_cash.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/payment_offline.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/personal_payment_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/personal_transaction_detail_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/personal_transaction_patient_information_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/transaction_history/transaction_history_view.dart';
import 'package:kayabe_lims/app/modules/update_personal_info/bindings/update_personal_info_binding.dart';
import 'package:kayabe_lims/app/modules/update_personal_info/views/update_personal_info_screen.dart';
import 'package:kayabe_lims/app/modules/dashboard/views/dashboard.dart';
import 'package:kayabe_lims/app/modules/splash/views/splashscreen.dart';
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
  static const profile = Routes.profile;

  static const personalTransactionDetail = Routes.personalTransactionDetail;
  static const organizationTransactionDetail =
      Routes.organizationTransactionDetail;
  static const transactionPatientList = Routes.transactionPatientList;
  static const personalTransactionPatientInformation =
      Routes.personalTransactionPatientInformation;
  static const medicalQuestionnaireList = Routes.medicalQuestionnaireList;
  static const medicalHistory = Routes.medicalHistory;
  static const invoice = Routes.invoice;
  static const personalPayment = Routes.personalPayment;
  static const organizationPayment = Routes.organizationPayment;
  static const paymentOffline = Routes.paymentOffline;
  static const paymentCash = Routes.paymentCash;
  static const aboutUs = Routes.aboutUs;
  static const services = Routes.services;
  static const helpCenter = Routes.helpCenter;
  static const changePassword = Routes.changePassword;
  static const personalInformation = Routes.personalInformation;
  static const articleHome = Routes.articleHome;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.signin,
      page: () => const SignInScreen(),
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
    GetPage(
      name: _Paths.updatePersonalInfo,
      page: () => const UpdatePersonalInfoScreen(),
      binding: UpdatePersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.personalBooking,
      page: () => const PersonalBooking(),
      binding: PersonalBookingBinding(),
    ),
    GetPage(
      name: _Paths.questionnaire,
      page: () => const Questionnaire(),
      binding: PersonalBookingBinding(),
    ),
    GetPage(
      name: _Paths.organizationBooking,
      page: () => const OrganizationBooking(),
      binding: OrganizationBookingBinding(),
    ),
    GetPage(
      name: _Paths.transactionHistory,
      page: () => const TransactionHistoryView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileView(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: _Paths.personalTransactionDetail,
      page: () => const ProfileView(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: _Paths.personalTransactionDetail,
      page: () => const PersonalTransactionDetailView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.organizationTransactionDetail,
      page: () => const OrganizationTransactionDetailView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.transactionPatientList,
      page: () => const TransactionPatientListView(),
    ),
    GetPage(
      name: _Paths.personalTransactionPatientInformation,
      page: () => const PersonalTransactionPatientInformationView(),
    ),
    GetPage(
      name: _Paths.medicalQuestionnaireList,
      page: () => const MedicalQuestionnarieView(),
    ),
    GetPage(
      name: _Paths.medicalHistory,
      page: () => const MedicalHistoryView(),
    ),
    GetPage(
      name: _Paths.invoice,
      page: () => const InvoiceView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.personalPayment,
      page: () => const PersonalPaymentView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.organizationPayment,
      page: () => const OrganizationPaymentView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.paymentOffline,
      page: () => const PaymentOfflineView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.paymentCash,
      page: () => const PaymentCashView(),
      binding: TransactionHistoryViewBinding(),
    ),
    GetPage(
      name: _Paths.aboutUs,
      page: () => const AboutView(),
    ),
    GetPage(
      name: _Paths.services,
      page: () => const ServiceView(),
    ),
    GetPage(
      name: _Paths.helpCenter,
      page: () => const HelpCenterView(),
      binding: ProfileViewBinding(),
    ),
    GetPage(
      name: _Paths.changePassword,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: _Paths.personalInformation,
      page: () => const PersonalInformation(),
    ),
    GetPage(
      name: _Paths.articleHome,
      page: () => const ArticleHomeView(),
      transition: Transition.noTransition,
    )
  ];
}
