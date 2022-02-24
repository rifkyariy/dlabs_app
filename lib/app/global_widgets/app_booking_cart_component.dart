import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBookingCartComponent extends StatelessWidget {
  const AppBookingCartComponent(
      {Key? key, this.title, this.desc, this.icon, this.url})
      : super(key: key);
  final String? title, desc;
  final IconData? icon;
  final String? url;

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
                        title ?? "",
                        style: appBannerTitleTextStyle,
                      ),
                      Icon(
                        icon,
                        color: whiteColor,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    desc ?? "",
                    style: smallTextStyle(Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeScalling().setHeight(100),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Close Bottom Sheet
                  Navigator.pop(context);

                  // Route to Personal Booking
                  Get.toNamed(url ?? '');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
