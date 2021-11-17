import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InputFieldContainer extends StatelessWidget {
  final Widget child;
  bool status;

  InputFieldContainer({
    Key? key,
    required this.child,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(4.8),
          border: Border.all(color: status ? dangerColor : lightGreyColor)),
      child: child,
    );
  }
}
