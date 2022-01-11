import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/transaction_history/transaction_history_view.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final AuthController _authController = Get.find();

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
                      if (_authController.isLoggedIn.value) {
                        Get.to(
                          () => const TransactionHistoryView(),
                          binding: TransactionHistoryViewBinding(),
                        );
                      } else {
                        // Redirect into sign in pages
                        Get.toNamed(AppPages.signin);
                        Get.snackbar(
                          "Please login to continue",
                          "",
                          backgroundColor: primaryColor,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: const Duration(seconds: 1),
                          colorText: whiteColor,
                        );
                      }
                      break;
                    case 2:
                      middleButtonPressed!();

                      break;
                    case 3:
                      if (_authController.isLoggedIn.value) {
                        Get.snackbar(
                          "Uh oh.",
                          "No Route to Host",
                          backgroundColor: primaryColor,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: const Duration(seconds: 1),
                          colorText: whiteColor,
                        );
                      } else {
                        // Redirect into sign in pages
                        Get.toNamed(AppPages.signin);
                        Get.snackbar(
                          "Please login to continue",
                          "",
                          backgroundColor: primaryColor,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: const Duration(seconds: 1),
                          colorText: whiteColor,
                        );
                      }
                      break;
                    case 4:
                      if (_authController.isLoggedIn.value) {
                        Get.snackbar(
                          "Uh oh.",
                          "No Route to Host",
                          backgroundColor: primaryColor,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: const Duration(seconds: 1),
                          colorText: whiteColor,
                        );
                      } else {
                        // Redirect into sign in pages
                        Get.toNamed(AppPages.signin);
                        Get.snackbar(
                          "Please login to continue",
                          "",
                          backgroundColor: primaryColor,
                          snackPosition: SnackPosition.TOP,
                          animationDuration: const Duration(seconds: 1),
                          duration: const Duration(seconds: 1),
                          colorText: whiteColor,
                        );
                      }
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
