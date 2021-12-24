import 'dart:async';

import 'package:dlabs_apps/app/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    startSplashScreen();
    super.initState();
  }

  startSplashScreen() async {
    controller.getCompanyData();

    var duration = const Duration(seconds: 1);

    return Timer(duration, () {
      controller.isUserSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Obx(
          () => Visibility(
            child: Image.network('${controller.companyLogo.value}',
                width: 140, height: 140),
            visible: controller.isVisible.value,
          ),
        ),
      ),
    );
  }
}
