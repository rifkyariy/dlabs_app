import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onClicked;
  final bool? isLoading;

  const AppButton({
    required this.text,
    required this.textColor,
    required this.onClicked,
    Key? key,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading ?? false
        ? ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(whiteColor)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: subtitleTextStyle(textColor),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.8), // <-- Radius
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onClicked,
            child: Text(
              text,
              style: subtitleTextStyle(textColor),
            ),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
              minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.8), // <-- Radius
              ),
            ),
          );
  }
}
