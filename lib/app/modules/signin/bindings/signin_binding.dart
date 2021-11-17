import 'package:dlabs_apps/app/data/services/auth_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
