import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/modules/update_personal_info/controller/update_personal_info_controller.dart';
import 'package:get/get.dart';

class UpdatePersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(),
    );
    Get.lazyPut<UpdatePersonalInfoController>(
      () => UpdatePersonalInfoController(),
    );
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
    Get.lazyPut<AppStorageService>(
      () => AppStorageService(),
    );
  }
}
