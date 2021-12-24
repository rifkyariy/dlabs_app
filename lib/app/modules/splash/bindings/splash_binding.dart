import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/signin/controller/signin_controller.dart';
import 'package:dlabs_apps/app/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());
  }
}
