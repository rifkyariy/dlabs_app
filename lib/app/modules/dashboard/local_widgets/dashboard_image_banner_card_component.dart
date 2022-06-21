import 'package:cached_network_image/cached_network_image.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DashboardImageBannerCardComponent extends StatelessWidget {
  const DashboardImageBannerCardComponent({
    Key? key,
    this.onPressed,
    required this.imageURL,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String imageURL, title, subtitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);
    SizeScalling sizeScalling = SizeScalling();
    return SizedBox(
      height: 200,
      child: CachedNetworkImage(
        imageUrl: imageURL,
        imageBuilder: (context, imageProvider) => Stack(children: [
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            // width: sizeScalling.setWidth(315),
            decoration: BoxDecoration(
              color: const Color(0xff212121),
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
                image: CachedNetworkImageProvider(imageURL),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 170, 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appBannerTitleTextStyle,
                  ),
                  Text(
                    subtitle,
                    style: appBannerSubTitleTextStyle,
                  ),
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
        ]),
      ),
    );
  }
}
