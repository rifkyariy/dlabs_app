import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_bottom_sheet_component.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_banner_component.dart';
import 'package:kayabe_lims/app/modules/dashboard/local_widgets/dashboard_service_card_component.dart';
import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';

import 'dashboard_banner_card_component.dart';

class DashboardBannerListComponent extends StatelessWidget {
  const DashboardBannerListComponent({
    Key? key,
    required this.bannerList,
  }) : super(key: key);
  final List bannerList;

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);
    final AuthController _authController = Get.find();

    return SizedBox(
      height: SizeScalling().setHeight(150),
      width: double.infinity,
      child: ListView.separated(
        itemCount: bannerList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
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
            return DashboardServiceCardComponent(
              title: bannerList[index].title,
              price: bannerList[index].desc,
              subtitle: bannerList[index].redirectType,
            );
          }
        },
        separatorBuilder: (context, item) {
          return SizedBox(width: SizeScalling().setWidth(15));
        },
      ),
    );
  }
}
