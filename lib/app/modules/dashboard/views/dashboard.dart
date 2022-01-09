import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_bottom_sheet_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_scaffold_with_navbar.dart';
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
    SizeScalling.init(context);
    return AppScaffoldWithBottomNavBar(
      visibleBottomNavBar: true,
      visibleFloatingActionButton: true,
      currentIndex: 0,
      middleButtonPressed: () {
        // Check if user authenticated based on name
        if (fullName != null) {
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
                    name: controller.fullname.value != ''
                        ? fullName!.split(" ").elementAt(0)
                        : '',
                    notificationExist:
                        controller.fullname.value != '' ? true : false,
                    notificationCount: 0,
                    gender: controller.gender.value,
                    photoUrl: controller.photoUrl.value,
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
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
