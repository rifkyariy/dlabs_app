import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'app_booking_cart_component.dart';

class AppBottomSheetComponent extends StatelessWidget {
  const AppBottomSheetComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeScalling().setHeight(380),
      padding: const EdgeInsets.only(left: 51, right: 51, top: 33),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('bottomsheet_book_now'.tr, style: titleTextStyle(primaryColor)),
          Text(
            'bottomsheet_subtitle'.tr,
            style: appServiceSubtitleTextStyle,
          ),
          AppBookingCartComponent(
            title: 'bottomsheet_personal'.tr,
            desc: 'bottomsheet_personal_subtitle'.tr,
            icon: AppIcons.profile,
            url: AppPages.personalBooking,
          ),
          AppBookingCartComponent(
            title: 'bottomsheet_organization'.tr,
            desc: 'bottomsheet_organization_subtitle'.tr,
            icon: AppIcons.group,
            url: AppPages.organizationBooking,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: greyColor,
              alignment: Alignment.bottomCenter,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(AppIcons.close),
            label: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
