import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
  }
}
