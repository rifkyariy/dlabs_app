import 'dart:async';

import 'package:get/get.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 1);

    return Timer(duration, () {
      Get.toNamed(AppPages.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
          child: Image.asset(
        'assets/image/logo-dlab.png',
        width: 160,
        height: 70,
      )),
    );
  }
}
