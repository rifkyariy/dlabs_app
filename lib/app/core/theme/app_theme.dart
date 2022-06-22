import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff323F4B);
Color primaryColor = const Color(0xff1176BC);
Color dangerColor = const Color(0xffE8322F);
Color warningColor = const Color(0xffFFA031);
Color greyColor = const Color(0xffA0A0A0);
Color lightGreyColor = const Color(0xffCED4DA);
Color greenSuccessColor = const Color(0xFF28A745);
Color redAlertColor = const Color(0xFFDC3545);
Color scaffoldBackgroundColor = const Color(0xFFFBFBFB);

TextStyle titleTextStyle(textColor) => GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    );

TextStyle appBannerTitleTextStyle = GoogleFonts.lato(
    color: whiteColor, fontSize: 18, fontWeight: FontWeight.w700);

TextStyle appBannerSubTitleTextStyle = GoogleFonts.lato(
    color: whiteColor, fontSize: 10, fontWeight: FontWeight.w500);

TextStyle appServicePriceTextStyle = GoogleFonts.lato(
    color: primaryColor, fontSize: 14, fontWeight: FontWeight.w700);

TextStyle appServiceSubtitleTextStyle = GoogleFonts.lato(
    color: greyColor, fontSize: 12, fontWeight: FontWeight.w500);

TextStyle appBannerButtonTextStyle = GoogleFonts.lato(
    color: whiteColor, fontSize: 9, fontWeight: FontWeight.w500);

TextStyle appAvatarNameTextStyle = GoogleFonts.lato(
    color: primaryColor, fontSize: 24, fontWeight: FontWeight.w600);

TextStyle appNotificationNumberTextStyle = GoogleFonts.poppins(
    color: whiteColor, fontSize: 8, fontWeight: FontWeight.w700);

TextStyle appAvatarSubtitleTextStyle = GoogleFonts.lato(
    color: greyColor, fontSize: 14, fontWeight: FontWeight.w400);

TextStyle subtitleTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 16);

TextStyle mediumTextStyle(Color textColor, {double? fontSize}) =>
    GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 16,
    );

TextStyle appTextStyleLatoFs14Fw500 = GoogleFonts.lato(
    color: blackColor, fontSize: 14, fontWeight: FontWeight.w500);

TextStyle regularTextStyle(Color textColor, {double? fontSize}) =>
    GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontSize: fontSize ?? 14,
      height: 1.6,
    );

TextStyle smallTextStyle(Color textColor, {double? fontSize}) =>
    GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 11,
      height: 1.4,
    );

TextStyle BoldTextStyle(Color textColor, {double? fontSize}) =>
    GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: fontSize ?? 16,
    );

TextStyle BoldTinyTextStyle(Color textColor, {double? fontSize}) =>
    GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontSize: fontSize ?? 12,
    );
