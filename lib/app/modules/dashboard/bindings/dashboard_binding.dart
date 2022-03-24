import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/repository/dashboard_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<DashboardRepository>(() => DashboardRepository());
  }
}
