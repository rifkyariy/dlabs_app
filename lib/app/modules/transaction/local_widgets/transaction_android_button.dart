import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionTextButton extends StatelessWidget {
  const TransactionTextButton({
    Key? key,
    this.onPressed,
    this.isWhiteBackground,
    required this.title,
    this.isRedBackground = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool? isWhiteBackground;
  final String title;
  final bool isRedBackground;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      /// If online then close if offline then fuck
      onPressed: onPressed,
      child: Text(
        title,
        style: regularTextStyle(
          isRedBackground
              ? dangerColor
              : (isWhiteBackground ?? false ? primaryColor : whiteColor),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: isRedBackground
            ? whiteColor
            : (isWhiteBackground ?? false ? whiteColor : primaryColor),
        minimumSize: const Size(double.infinity, 45),
        side: BorderSide(color: isRedBackground ? dangerColor : primaryColor),
      ),
    );
  }
}
