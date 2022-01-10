import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
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
    SizeScalling.init(context);
    SizeScalling sizeScalling = SizeScalling();
    return SizedBox(
      height: sizeScalling.setHeight(115),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: sizeScalling.setHeight(110),
            width: sizeScalling.setWidth(252),
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
            height: sizeScalling.setHeight(110),
            width: sizeScalling.setWidth(252),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.snackbar(
                    "Something Went Wrong",
                    "No Route Specified",
                    backgroundColor: primaryColor,
                    snackPosition: SnackPosition.TOP,
                    animationDuration: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1),
                    colorText: whiteColor,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
