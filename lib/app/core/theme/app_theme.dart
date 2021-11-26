import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = const Color(0xffFFFFFF);
Color blackColor = const Color(0xff323F4B);
Color primaryColor = const Color(0xff1176BC);
Color dangerColor = const Color(0xffE8322F);
Color warningColor = const Color(0xffFFA031);
Color greyColor = const Color(0xffA0A0A0);
Color lightGreyColor = const Color(0xffE0E0E0);

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

TextStyle mediumTextStyle(Color textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w500, fontSize: 16);

TextStyle regularTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 14);

TextStyle smallTextStyle(Color textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w500, fontSize: 11);

TextStyle appTextStyleLatoFs14Fw500 = GoogleFonts.lato(
    color: blackColor, fontSize: 14, fontWeight: FontWeight.w500);

TextStyle BoldTextStyle(Color textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w700, fontSize: 16);
