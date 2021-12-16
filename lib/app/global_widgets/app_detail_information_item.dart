import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDetailInformationItem extends StatelessWidget {
  const AppDetailInformationItem(
    this.text, {
    Key? key,
    this.color,
    this.style,
    this.padding,
  }) : super(key: key);

  /// The text
  /// This is the title text
  final String text;

  /// Text Color
  final Color? color;

  /// Text Style Override
  final TextStyle? style;

  /// Padding override, default is top 10
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            text,
            style: style ??
                regularTextStyle(
                  color ?? greyColor,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
