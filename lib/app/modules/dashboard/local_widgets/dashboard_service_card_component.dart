import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class DashboardServiceCardComponent extends StatelessWidget {
  const DashboardServiceCardComponent({
    Key? key,
    required this.title,
    required this.price,
    required this.subtitle,
  }) : super(key: key);

  final String title, price, subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeScalling().setHeight(115),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: SizeScalling().setHeight(110),
            width: SizeScalling().setWidth(252),
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/image/app-service-banner.png'),
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
                        title,
                        style: mediumTextStyle(blackColor),
                      ),
                      Text("Rp $price", style: appServicePriceTextStyle),
                    ],
                  ),
                ),
                Text(
                  subtitle,
                  style: appServiceSubtitleTextStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeScalling().setHeight(110),
            width: SizeScalling().setWidth(252),
            child: Positioned.fill(
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
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
