import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:kayabe_lims/app/modules/signin/controller/signin_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
