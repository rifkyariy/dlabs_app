import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class ProfileViewController extends GetxController {
  AuthController auth = Get.find();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  RxBool imageLoadError = false.obs;

  onSignOutButtonPressed() {
    auth.handleLogout();
  }

  onSignInButtonPressed() {
    Get.toNamed(AppPages.signin);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
