import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
            ),
            color: Color(0xff000000),
            onPressed: () => Navigator.pop(context)),
        title: Text('title', style: mediumTextStyle(blackColor)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_outlined),
              color: Color(0xff000000),
              onPressed: () {}),
        ],
        backgroundColor: whiteColor,
        shadowColor: lightGreyColor);
  }
}
