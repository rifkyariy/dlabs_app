import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kayabe_lims/app/core/internationalization/app_internationalization.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  await initializeDateFormatting('id_ID')
      .then((_) => runApp(const ProviderScope(child: Apps())));
}

class Apps extends StatelessWidget {
  const Apps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: AppPages.splash,
        translations: AppInternationalization(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Color(0xFF1176BC),
            ),
            titleTextStyle: BoldTextStyle(
              const Color(0xFF323F4B),
            ),
            centerTitle: true,
            elevation: 2.0,
            backgroundColor: Colors.white,
            shadowColor: lightGreyColor,
          ),
        ),
        builder: EasyLoading.init(),
      ),
    );
  }
}
