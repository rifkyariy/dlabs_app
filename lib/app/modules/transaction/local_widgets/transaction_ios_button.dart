import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TransactionIosButton extends StatelessWidget {
  const TransactionIosButton({Key? key, this.onPressed, required this.title})
      : super(key: key);

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      /// If online then close if offline then fuck
      onPressed: onPressed,
      child: Text(
        title,
        style: BoldTextStyle(primaryColor),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 20),
        side: BorderSide.none,
        elevation: 0,
      ),
    );
  }
}
