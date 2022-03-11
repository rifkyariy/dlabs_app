import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/profile/controller/profile_view_controller.dart';

class ChangePassword extends GetView<ProfileViewController> {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
          centerTitle: true,
          actions: const [],
          elevation: 1.0,
          backgroundColor: whiteColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            color: blackColor,
            onPressed: () => Navigator.pop(context),
          ),
          title:
              Text('profile_change_pass'.tr, style: BoldTextStyle(blackColor)),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 24, left: 24.0, right: 24.0),
                child: Column(
                  children: [
                    // Forgot Password
                    // Label Old Password
                    Obx(
                      () => TextInput(
                          label: 'gen_old_password'.tr,
                          name: 'password',
                          errorMsg: controller.oldPasswordErrorMessage.value,
                          type: 'password',
                          controller: controller.oldPasswordController),
                    ),
                    Obx(
                      () => TextInput(
                        label: 'gen_new_password'.tr,
                        name: 'password',
                        errorMsg: controller.newPasswordErrorMessage.value,
                        type: 'password',
                        controller: controller.newPasswordController,
                      ),
                    ),
                    Obx(
                      () => TextInput(
                        label: 'gen_confirm_password'.tr,
                        name: 'password',
                        errorMsg: controller.confirmPasswordErrorMessage.value,
                        type: 'password',
                        controller: controller.confirmPasswordController,
                      ),
                    ),
                    Obx(
                      () => AppButton(
                        text: 'profile_change_pass'.tr,
                        textColor: whiteColor,
                        onClicked: () {
                          controller.handleChangePassword();
                        },
                        isLoading: controller.isLoading.value,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/bg-overlay-ambulance.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
        ));
  }
}
