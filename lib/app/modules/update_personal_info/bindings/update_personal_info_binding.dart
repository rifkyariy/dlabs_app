import 'package:dlabs_apps/app/data/repository/auth_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/modules/update_personal_info/controller/update_personal_info_controller.dart';
import 'package:get/get.dart';

class UpdatePersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<UpdatePersonalInfoController>(
      () => UpdatePersonalInfoController(),
    );
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
