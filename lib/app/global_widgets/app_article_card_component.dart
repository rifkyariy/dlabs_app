import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppArticleCardComponent extends StatelessWidget {
  const AppArticleCardComponent({
    Key? key,
    required this.about,
    required this.title,
    required this.timestamp,
    required this.photoUrl,
  }) : super(key: key);
  final String about, title, timestamp, photoUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.snackbar(
            "Error",
            "No Route Specified",
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.TOP,
            animationDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 1),
            colorText: whiteColor,
          );
        },
        child: SizedBox(
          height: SizeScalling().setHeight(120),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: SizeScalling().setWidth(110),
                height: SizeScalling().setHeight(120),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(photoUrl),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(17, 11, 35, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(
                          7,
                          2,
                          7,
                          2,
                        ),
                        margin: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        height: 15,
                        width: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: primaryColor,
                        ),
                        child: Text(
                          "Covid 19",
                          style: appBannerButtonTextStyle,
                        ),
                      ),
                      Text(
                        title,
                        style: appTextStyleLatoFs14Fw500,
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule,
                            color: greyColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            timestamp,
                            style: smallTextStyle(greyColor),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
