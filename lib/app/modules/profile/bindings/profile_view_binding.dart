import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/profile/controller/profile_view_controller.dart';

class ProfileViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileViewController>(() => ProfileViewController());
    // Get.lazyPut<AuthController>(() => AuthController());
  }
}
