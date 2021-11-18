import 'package:dlabs_apps/app/modules/forgot_password/controller/forgot_password_controller.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}
