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
          Text("Book Now", style: titleTextStyle(primaryColor)),
          Text(
            "Please, choose who this medical test is needed for",
            style: appServiceSubtitleTextStyle,
          ),
          const AppBookingCartComponent(
            title: 'Personal',
            desc:
                'This option is provided for personal needs. For private and seamless service ',
            icon: AppIcons.profile,
            url: AppPages.personalBooking,
          ),
          const AppBookingCartComponent(
            title: 'Organization',
            desc:
                'This option is provided for organization needs. For security and safety at work',
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
