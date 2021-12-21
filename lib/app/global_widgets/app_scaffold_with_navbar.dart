import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/modules/transaction/bindings/transaction_history_binding.dart';

import 'package:dlabs_apps/app/modules/transaction/views/transaction_history/transaction_history_view.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppScaffoldWithBottomNavBar extends StatelessWidget {
  const AppScaffoldWithBottomNavBar({
    Key? key,
    required this.body,
    this.currentIndex,
    this.visibleBottomNavBar,
    this.appBar,
    this.middleButtonPressed,
    this.visibleFloatingActionButton,
  }) : super(key: key);

  final Widget body;
  final int? currentIndex;
  final PreferredSizeWidget? appBar;
  final bool? visibleBottomNavBar;
  final bool? visibleFloatingActionButton;
  final void Function()? middleButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: visibleBottomNavBar ?? false
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) async {
                if (index == currentIndex) {
                  return;
                } else {
                  switch (index) {
                    case 0:
                      Get.offAndToNamed(AppPages.dashboard);
                      break;
                    case 1:
                      // Get.toNamed(AppPages.signin);

                      Get.to(
                        () => TransactionHistoryView(),
                        binding: TransactionHistoryViewBinding(),
                      );
                      break;
                    case 2:
                      middleButtonPressed!();

                      break;
                    case 3:
                      Get.toNamed(AppPages.signin);

                      Get.to(
                        () => TransactionHistoryView(),
                        binding: TransactionHistoryViewBinding(),
                      );
                      break;
                    case 4:
                      final googlesigin = GoogleSignIn();
                      googlesigin.signOut();

                      SharedPreferences sp =
                          await SharedPreferences.getInstance();

                      sp.remove('googleKey');
                      sp.remove('apiToken');
                      sp.remove('googlePhotoUrl');
                      sp.remove('credentials');

                      Get.toNamed(AppPages.signin);

                      Get.snackbar(
                        "Info",
                        "Please login to continue",
                        backgroundColor: primaryColor,
                        snackPosition: SnackPosition.TOP,
                        animationDuration: const Duration(seconds: 1),
                        duration: const Duration(seconds: 1),
                        colorText: whiteColor,
                      );
                      break;
                  }
                }
              },
              currentIndex: currentIndex ?? 0,
              items: visibleFloatingActionButton ?? false
                  ? _itemsWithFloating
                  : _itemsWithoutFloating,
            )
          : const SizedBox(),
      body: SafeArea(child: body),
      floatingActionButton: visibleFloatingActionButton ?? false
          ? FloatingActionButton(
              enableFeedback: true,
              onPressed: middleButtonPressed,
              child: const Icon(AppIcons.booking),
            )
          : const SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

List<BottomNavigationBarItem> _itemsWithFloating = const [
  BottomNavigationBarItem(
    icon: Icon(AppIcons.home),
    label: "Home",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.history),
    label: "History",
  ),
  BottomNavigationBarItem(
    icon: SizedBox(height: 25),
    label: "Book Now",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.article),
    label: "Article",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.profile),
    label: "Profile",
  ),
];

List<BottomNavigationBarItem> _itemsWithoutFloating = const [
  BottomNavigationBarItem(
    icon: Icon(AppIcons.home),
    label: "Home",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.history),
    label: "History",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.article),
    label: "Article",
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.profile),
    label: "Profile",
  ),
];
