import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/modules/forgot_password/controller/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 84.0, left: 24.0, right: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Logo and Header
              Obx(
                () => Center(
                    child: controller.companyLogo.value.isNotEmpty
                        ? Image.network(
                            controller.companyLogo.value,
                            width: 100,
                          )
                        : null),
              ),
              const SizedBox(height: 60),
              // SizedBox(height: 0.2 * MediaQuery.of(context).size.height),

              Align(
                alignment: Alignment.centerLeft,
                child: Text('gen_forgot_password'.tr,
                    style: titleTextStyle(blackColor)),
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'forgot_pass_no_worries'.tr,
                  style: regularTextStyle(greyColor),
                ),
              ),
              const SizedBox(height: 24),

              // Email Address
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Email Input
                  Obx(
                    () => TextInput(
                      label: 'gen_email'.tr,
                      name: 'email',
                      placeholder: 'email_placeholder'.tr,
                      errorMsg: controller.emailErrorMessages.value,
                      controller: controller.emailController,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Obx(
                () => AppButton(
                  text: 'forgot_pass_reset'.tr,
                  textColor: whiteColor,
                  onClicked: () => controller.forgotPasswordHandler(),
                  isLoading: controller.isLoading.value,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
