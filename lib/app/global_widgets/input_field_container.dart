import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:flutter/material.dart';

class InputFieldContainer extends StatelessWidget {
  final Widget child;
  bool status;
  bool isDisabled;

  InputFieldContainer({
    Key? key,
    this.isDisabled = false,
    required this.child,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeScalling().setHeight(8)),
      padding: EdgeInsets.only(
          top: SizeScalling().setHeight(2),
          bottom: SizeScalling().setHeight(2),
          left: SizeScalling().setWidth(10),
          right: SizeScalling().setWidth(4)),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: isDisabled ? lightGreyColor : whiteColor,
        borderRadius: BorderRadius.circular(4.8),
        border: Border.all(
            width: 1.5, color: status ? dangerColor : lightGreyColor),
      ),
      child: child,
    );
  }
}
