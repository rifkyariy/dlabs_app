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
        elevation: 0,
        backgroundColor: const Color(0xFF1579BE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: whiteColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profile', style: BoldTextStyle(whiteColor)),
      ),
      body: Column(
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
                Positioned(
                  // 86 is the radius of circular avatar
                  right: (MediaQuery.of(context).size.width / 2) - 86,
                  bottom: 0,
                  child: imageContainer(),
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
        ],
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
            Text('SETTING', style: mediumTextStyle(greyColor, fontSize: 12)),
            tileComponent('Personal Information'),
            tileComponent('Password'),
            tileComponent('History Transaction', onTap: () {
              if (controller.auth.isLoggedIn.value) {
                Get.to(
                  () => const TransactionHistoryView(),
                  // binding: TransactionHistoryViewBinding(),
                );
              } else {
                // Redirect into sign in pages
                Get.toNamed(AppPages.signin);
                Get.snackbar(
                  "Please login to continue",
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
            Text('ABOUT', style: mediumTextStyle(greyColor, fontSize: 12)),
            tileComponent('About Us'),
            tileComponent('Help Center'),
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
                  signedIn ? 'Sign Out' : 'Sign In',
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
              () => CircleAvatar(
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
                  onPressed: () {
                    // TODO update profile picture
                    print("object");
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
              "Are you sure want to sign out?",
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
          title: 'Yes',
          isWhiteBackground: false,
          onPressed: () {
            controller.onSignOutButtonPressed();
            Get.back();
          },
        ),
        const SizedBox(height: 15),
        TransactionTextButton(
          title: 'No',
          isWhiteBackground: true,
          onPressed: () async {
            Get.back();
          },
        )
      ],
    );
  }
}
