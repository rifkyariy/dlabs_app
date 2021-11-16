import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color whiteColor = Color(0xffFFFFFF);
Color blackColor = Color(0xff323F4B);
Color primaryColor = Color(0xff1176BC);
Color dangerColor = Color(0xffE8322F);
Color greyColor = Color(0xffA0A0A0);
Color lightGreyColor = Color(0xffE0E0E0);

TextStyle titleTextStyle(textColor) => GoogleFonts.lato(
      color: textColor,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    );

TextStyle subtitleTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 16);

TextStyle MediumTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w500, fontSize: 16);

TextStyle regularTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w400, fontSize: 14);

TextStyle SmallTextStyle(textColor) => GoogleFonts.lato(
    color: textColor, fontWeight: FontWeight.w500, fontSize: 11);
