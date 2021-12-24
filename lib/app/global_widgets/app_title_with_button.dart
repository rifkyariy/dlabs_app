import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppTitleWithButton extends StatelessWidget {
  const AppTitleWithButton({
    Key? key,
    this.onTap,
    required this.title,
    required this.buttonLabel,
    this.titleColor,
    this.padding,
    this.buttonLabelColor,
  }) : super(key: key);

  /// This is the title
  /// Left Positioned
  final String title;

  /// This is the button Text.
  /// Button are using Gesture Detector
  final String buttonLabel;

  /// This is the title Color
  final Color? titleColor;

  /// This is the button label Color.
  final Color? buttonLabelColor;

  /// This is the content Padding
  final EdgeInsetsGeometry? padding;

  /// Callback for buttons
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(25, 11, 25, 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: BoldTextStyle(titleColor ?? blackColor, fontSize: 12),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonLabel,
              style: BoldTextStyle(
                buttonLabelColor ?? primaryColor,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
