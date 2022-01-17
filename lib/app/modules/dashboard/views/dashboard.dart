import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_bottom_sheet_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_scaffold_with_navbar.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_banner_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_header_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_service_component.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({
    this.fullName,
    this.gender,
    this.photoUrl,
    Key? key,
  }) : super(key: key);
  final String? fullName, gender, photoUrl;

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    SizeScalling.init(context);
    return AppScaffoldWithBottomNavBar(
      visibleBottomNavBar: true,
      visibleFloatingActionButton: true,
      currentIndex: 0,
      middleButtonPressed: () {
        // Check if user authenticated based on name
        if (_authController.isLoggedIn.value) {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const AppBottomSheetComponent();
            },
          );
        } else {
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
      },
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Component
                Obx(
                  () => DashboardHeaderComponent(
                    name: _authController.fullname.value != ''
                        ? _authController.fullname.value.split(" ").elementAt(0)
                        : '',
                    notificationExist:
                        _authController.fullname.value != '' ? true : false,
                    notificationCount: 0,
                    gender: _authController.gender.value,
                    photoUrl: _authController.photoUrl.value,
                  ),
                ),

                // Banner
                DashboardBannerComponent(onPressed: () {
                  Get.offAndToNamed(AppPages.signin);

                  Get.snackbar(
                    "Please login to continue",
                    "",
                    backgroundColor: primaryColor,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1),
                    colorText: whiteColor,
                  );
                }),

                // Our Service
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeScalling().setHeight(26),
                      bottom: SizeScalling().setHeight(17),
                      left: SizeScalling().setWidth(0)),
                  child: Text(
                    "Our Service",
                    style: mediumTextStyle(Colors.black),
                  ),
                ),

                DashboardServiceComponent(
                  serviceData: controller.dummyServiceData,
                ),

                // Article
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeScalling().setHeight(26),
                    bottom: SizeScalling().setHeight(17),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Article",
                        style: mediumTextStyle(Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAndToNamed(AppPages.signin);

                          Get.snackbar(
                            "Please login to continue",
                            "",
                            backgroundColor: primaryColor,
                            snackPosition: SnackPosition.TOP,
                            animationDuration: const Duration(seconds: 1),
                            duration: const Duration(seconds: 1),
                            colorText: whiteColor,
                          );
                        },
                        child: Text(
                          "View All",
                          style: appServicePriceTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                AppArticleCardComponent(
                  about: controller.dummyArticleData[0].about,
                  title: controller.dummyArticleData[0].title,
                  photoUrl: controller.dummyArticleData[0].photoUrl,
                  timestamp: controller.dummyArticleData[0].timestamp,
                ),
                AppArticleCardComponent(
                  about: controller.dummyArticleData[1].about,
                  title: controller.dummyArticleData[1].title,
                  photoUrl: controller.dummyArticleData[1].photoUrl,
                  timestamp: controller.dummyArticleData[1].timestamp,
                ),

                SizedBox(
                  height: 20,
                ),

                TextButton(
                  onPressed: () async {
                    _authController.handleLogout();
                  },
                  child: Text(
                    'Logout',
                    style: mediumTextStyle(dangerColor),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
