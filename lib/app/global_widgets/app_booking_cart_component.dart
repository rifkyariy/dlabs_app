import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBookingCartComponent extends StatelessWidget {
  const AppBookingCartComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeScalling().setHeight(115),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: SizeScalling().setHeight(100),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/image/app-booking-banner.png'),
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal",
                        style: appBannerTitleTextStyle,
                      ),
                      Icon(
                        AppIcons.profile,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
                Text(
                  "This option is provided for personal needs. For private and seamless service ",
                  style: smallTextStyle(Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeScalling().setHeight(100),
            width: double.infinity,
            child: Positioned.fill(
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO Change This Implement Head to Head
                    Get.snackbar(
                      "Error",
                      "No Route Specified",
                      backgroundColor: dangerColor,
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: const Duration(seconds: 1),
                      duration: const Duration(seconds: 1),
                      colorText: whiteColor,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
