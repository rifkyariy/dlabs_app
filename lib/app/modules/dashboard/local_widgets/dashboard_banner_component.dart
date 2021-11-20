import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';

class DashboardBannerComponent extends StatelessWidget {
  const DashboardBannerComponent({Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 30),
      width: double.infinity,
      height: SizeScalling().setHeight(146),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/image/app-book-banner.png'),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 16, 170, 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book an Appointment',
              style: appBannerTitleTextStyle,
            ),
            Text(
              'Please indicate if you want to book a specific time or test',
              style: appBannerSubTitleTextStyle,
            ),
            SizedBox(
              width: 110,
              height: 20,
              child: TextButton(
                onPressed: onPressed,
                child: const Text('Booking Test'),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF1880C7),
                  side: const BorderSide(color: Colors.white),
                  textStyle: appBannerButtonTextStyle,
                  primary: Colors.white,
                  padding: EdgeInsets.zero,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
