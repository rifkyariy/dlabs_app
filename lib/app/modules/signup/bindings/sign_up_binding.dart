import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/modules/signup/controller/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
