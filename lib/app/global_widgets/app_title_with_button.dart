import 'package:kayabe_lims/app/core/theme/app_theme.dart';
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
    this.trailing,
    this.leadingSize,
    this.trailingSize,
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

  /// Widget behind button
  final Widget? trailing;

  final double? leadingSize;

  final double? trailingSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding ?? const EdgeInsets.fromLTRB(25, 11, 25, 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: BoldTextStyle(
              titleColor ?? blackColor,
              fontSize: leadingSize ?? 12,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonLabel,
              style: BoldTextStyle(
                buttonLabelColor ?? primaryColor,
                fontSize: trailingSize ?? 12,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: trailing ?? const SizedBox(),
          )
        ],
      ),
    );
  }
}
