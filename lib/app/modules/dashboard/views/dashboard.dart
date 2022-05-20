import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_bottom_sheet_component.dart';
import 'package:kayabe_lims/app/global_widgets/app_scaffold_with_navbar.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/controller/dashboard_controller.dart';
import 'package:kayabe_lims/app/global_widgets/app_article_card_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_banner_card_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_banner_list_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_header_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_image_banner_card_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_service_card_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_service_component.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    final double height = MediaQuery.of(context).size.height;

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
            "pop_login_required".tr,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Obx(() => CarouselSlider(
                        options: CarouselOptions(
                          height: SizeScalling().setHeight(150),
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                        ),
                        items: controller.bannerData.value.map((item) {
                          if (item.title == 'displayBanner') {
                            return DashboardBannerCardComponent(onPressed: () {
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
                                  "pop_login_required".tr,
                                  "",
                                  backgroundColor: primaryColor,
                                  snackPosition: SnackPosition.TOP,
                                  animationDuration: const Duration(seconds: 1),
                                  duration: const Duration(seconds: 1),
                                  colorText: whiteColor,
                                );
                              }
                            });
                          } else {
                            return DashboardImageBannerCardComponent(
                              title: item.title,
                              subtitle: item.desc,
                              imageURL: item.image,
                            );
                          }
                        }).toList(),
                      )),
                ),

                // Our Service
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeScalling().setHeight(26),
                      bottom: SizeScalling().setHeight(17),
                      left: SizeScalling().setWidth(0)),
                  child: Text(
                    "gen_our_service".tr,
                    style: mediumTextStyle(Colors.black),
                  ),
                ),

                // Service List
                Obx(
                  () => DashboardServiceComponent(
                    serviceData: controller.serviceData.value,
                  ),
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
                        "gen_article".tr,
                        style: mediumTextStyle(Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppPages.articleHome,
                          );
                        },
                        child: Text(
                          "gen_view_all".tr,
                          style: appServicePriceTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Obx(
                  () => ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                          .articleData.length, //TODO change to fixed value,
                      itemBuilder: (context, index) => Column(children: [
                            AppArticleCardComponent(
                              about: controller.articleData[index].about,
                              title: controller.articleData[index].title,
                              photoUrl: controller.articleData[index].photoUrl,
                              timestamp:
                                  controller.articleData[index].timestamp,
                              id: 5,
                            ),
                          ])),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
