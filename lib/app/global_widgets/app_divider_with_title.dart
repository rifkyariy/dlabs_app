import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';

class AppDividerWithTitle extends StatelessWidget {
  const AppDividerWithTitle({Key? key, required this.title, this.fontSize})
      : super(key: key);

  const AppDividerWithTitle.visi({Key? key, this.title = 'Visi', this.fontSize})
      : super(key: key);

  const AppDividerWithTitle.misi({Key? key, this.title = 'Misi', this.fontSize})
      : super(key: key);

  const AppDividerWithTitle.price(
      {Key? key, this.title = 'Price', this.fontSize})
      : super(key: key);

  const AppDividerWithTitle.contactUs(
      {Key? key, this.title = 'Contact Us', this.fontSize})
      : super(key: key);

  final String title;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: BoldTextStyle(primaryColor, fontSize: fontSize)),
          Divider(
            height: 10,
            color: primaryColor,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
