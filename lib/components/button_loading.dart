import 'package:flutter/material.dart';
import 'package:dlabs_apps/theme.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onClicked;

  const LoadingButton({
    required this.text,
    required this.textColor,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(whiteColor)),
            ),
            SizedBox(
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
          minimumSize: Size(double.infinity, 46),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.8), // <-- Radius
          ),
        ),
      );
}
