import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/global_widgets/slideable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class AppSingleButtonSlideable extends StatelessWidget {
  const AppSingleButtonSlideable({
    Key? key,
    this.buttonPressed,
    this.title,
    this.subtitle,
    this.leading,
    this.buttonLabel,
    this.trailing,
    this.isThreeLine,
    this.icon,
  }) : super(key: key);

  final Function(BuildContext)? buttonPressed;
  final Widget? title, subtitle, leading, trailing;
  final String? buttonLabel;
  final bool? isThreeLine;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: buttonPressed,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            icon: icon ?? AppIcons.download,
            label: buttonLabel,
            labelStyle: mediumTextStyle(whiteColor, fontSize: 12),
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Column(
        children: [
          const Divider(height: 0),
          ListTile(
            isThreeLine: isThreeLine ?? false,
            leading: leading,
            title: title,
            subtitle: subtitle,
            trailing: trailing,
          ),
          const Divider(height: 0),
        ],
      ),
    );
  }
}
