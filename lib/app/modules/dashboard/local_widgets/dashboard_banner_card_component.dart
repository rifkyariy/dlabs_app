import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class DashboardBannerCardComponent extends StatelessWidget {
  const DashboardBannerCardComponent({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);
    SizeScalling sizeScalling = SizeScalling();
    return SizedBox(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            // width: double.infinity,
            width: sizeScalling.setWidth(315),
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
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
          ),
          SizedBox(
            height: sizeScalling.setHeight(300),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
