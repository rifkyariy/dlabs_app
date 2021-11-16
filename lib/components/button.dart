import 'package:flutter/material.dart';
import 'package:dlabs_apps/theme.dart';

class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onClicked;

  const Button({
    required this.text,
    required this.textColor,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        child: Text(
          text,
          style: subtitleTextStyle(textColor),
        ),
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          minimumSize: Size(double.infinity, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.8), // <-- Radius
          ),
        ),
      );
}
