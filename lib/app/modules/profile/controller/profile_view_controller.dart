import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class ProfileViewController extends GetxController {
  AuthController auth = Get.find();

  RxBool imageLoadError = false.obs;

  onSignOutButtonPressed() {
    auth.handleLogout();
  }

  onSignInButtonPressed() {
    Get.toNamed(AppPages.signin);
  }
}
