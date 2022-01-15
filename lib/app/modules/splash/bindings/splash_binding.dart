import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:kayabe_lims/app/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());
  }
}
