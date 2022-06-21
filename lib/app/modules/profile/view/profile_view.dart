import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/modules/profile/controller/profile_view_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_android_button.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/transaction_history/transaction_history_view.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

class ProfileView extends GetView<ProfileViewController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 1,
        backgroundColor: const Color(0xFF1579BE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: const Color(0xFFFFFFFF),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('menu_profile'.tr, style: BoldTextStyle(whiteColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Component
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.loose,
                children: [
                  Image.asset(
                    'assets/image/app-profile-background.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),

                  // Profile Picture Component
                  Obx(
                    () => Positioned(
                      // 86 is the radius of circular avatar
                      right: (MediaQuery.of(context).size.width / 2) - 86,
                      bottom: 0,
                      child: imageContainer(),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                controller.auth.fullname.value,
                style: mediumTextStyle(blackColor, fontSize: 26),
              ),
            ),
            controller.auth.isLoggedIn.value
                ? settingsComponent()
                : const SizedBox(),
            aboutComponent(signedIn: controller.auth.isLoggedIn.value),

            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget settingsComponent() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('profile_setting'.tr,
                style: mediumTextStyle(greyColor, fontSize: 12)),
            tileComponent('profile_personal_info'.tr, onTap: () {
              Get.toNamed(AppPages.personalInformation);
            }),
            tileComponent('profile_change_pass'.tr, onTap: () {
              Get.toNamed(AppPages.changePassword);
            }),
            tileComponent('profile_transaction_history'.tr, onTap: () {
              if (controller.auth.isLoggedIn.value) {
                Get.to(
                  () => const TransactionHistoryView(),
                  // binding: TransactionHistoryViewBinding(),
                );
              } else {
                // Redirect into sign in pages
                Get.toNamed(AppPages.signin);
                Get.snackbar(
                  "gen_login_required".tr,
                  "",
                  backgroundColor: primaryColor,
                  snackPosition: SnackPosition.TOP,
                  animationDuration: const Duration(seconds: 1),
                  duration: const Duration(seconds: 1),
                  colorText: whiteColor,
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget aboutComponent({required bool signedIn}) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('profile_about'.tr,
                style: mediumTextStyle(greyColor, fontSize: 12)),
            tileComponent('profile_about_us'.tr, onTap: () {
              Get.toNamed(AppPages.aboutUs);
            }),
            tileComponent('profile_services'.tr, onTap: () {
              Get.toNamed(AppPages.services);
            }),
            tileComponent('profile_help_center'.tr, onTap: () {
              Get.toNamed(AppPages.helpCenter);
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: signedIn
                    ? () {
                        Get.dialog(_androidDialog());
                      }
                    : () {
                        controller.onSignInButtonPressed();
                      },
                child: Text(
                  signedIn ? 'logout'.tr : 'login'.tr,
                  style: mediumTextStyle(signedIn ? dangerColor : primaryColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tileComponent(String title, {void Function()? onTap}) {
    return ListTile(
      leading: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }

  ImageProvider<Object>? getImageProvider() {
    print(controller.auth.gender.value);
    if (controller.imageLoadError.value ||
        controller.auth.photoUrl.value == '') {
      if (controller.auth.isLoggedIn.value) {
        switch (controller.auth.gender.value) {
          case '0':
            return const AssetImage(
                'assets/image/app-profile-picture-female.png');
          case '1':
            return const AssetImage(
                'assets/image/app-profile-picture-male.png');
          default:
            return const AssetImage('assets/image/app-logo.png');
        }
      } else {
        return const AssetImage('assets/image/app-logo.png');
      }
    } else {
      return NetworkImage(controller.auth.photoUrl.value);
    }
  }

  Widget imageContainer() {
    return SizedBox(
      height: 172,
      width: 172,
      child: Stack(
        children: [
          Container(
            child: Obx(
              () => controller.isLoading.value
                  ? const CircleAvatar(
                      radius: 86,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CircleAvatar(
                      radius: 86,

                      // Change to dynamic
                      backgroundImage: getImageProvider(),
                      onBackgroundImageError: (_, __) {
                        controller.imageLoadError.value = true;
                      },
                    ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: whiteColor,
                width: 4.0,
              ),
            ),
          ),
          Visibility(
            visible: controller.auth.isLoggedIn.value,
            child: Positioned(
              bottom: 10,
              right: 0,
              child: CircleAvatar(
                radius: 20,
                child: IconButton(
                  onPressed: () async {
                    /// TODO sini gan

                    await controller.onUpdateProfilePicturePressed();
                  },
                  icon: Icon(
                    Icons.photo_camera,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _androidDialog() {
    return SimpleDialog(
      title: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Warning!",
              style: BoldTextStyle(dangerColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              "pop_logout_alert".tr,
              style: regularTextStyle(
                blackColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      children: [
        TransactionTextButton(
          title: 'gen_yes'.tr,
          isWhiteBackground: false,
          onPressed: () {
            controller.onSignOutButtonPressed();
            Get.back();
          },
        ),
        const SizedBox(height: 15),
        TransactionTextButton(
          title: 'gen_no'.tr,
          isWhiteBackground: true,
          onPressed: () async {
            Get.back();
          },
        )
      ],
    );
  }
}
