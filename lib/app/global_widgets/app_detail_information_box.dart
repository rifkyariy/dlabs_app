import 'package:kayabe_lims/app/global_widgets/app_detail_information_item.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppDetailInformationBox extends StatelessWidget {
  const AppDetailInformationBox({
    Key? key,
    this.leading,
    this.trailing,
    this.header,
    this.title,
    this.bottom,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.flex,
    this.contentPadding,
    this.boxMargin,
    this.divider,
    this.boxPadding,
    this.dividerColor,
    this.dividerThickness,
  }) : super(key: key);

  /// Leading content.
  /// List of AppDetailInformationItem Widget
  final List<AppDetailInformationItem>? leading;

  /// Trailing content.
  /// List of AppDetailInformationItem Widget
  final List<AppDetailInformationItem>? trailing;

  /// Bottom Content.
  /// This is has the same layout as the header.
  /// List of AppDetailInformationItem Widget
  final List<Widget>? bottom;

  /// Header content
  /// We can put any widget here
  final Widget? header;

  /// Title content
  /// This is the title below the header part
  final String? title;

  /// This is the box background color.
  final Color? backgroundColor;

  /// Box Shadow Color
  final Color? shadowColor;

  /// Box Elevation
  final double? elevation;

  /// Leading and Trailing flex
  final FlexGroup? flex;

  /// Content padding
  /// Padding inside the box
  /// Does not include the header
  final EdgeInsetsGeometry? contentPadding;

  /// The box Margin
  final EdgeInsetsGeometry? boxMargin;

  /// Padding on the box, it's also incluede the header
  final EdgeInsetsGeometry? boxPadding;

  /// This is widget exactly below header.
  final Widget? divider;

  /// Header divider color
  final Color? dividerColor;

  final double? dividerThickness;

  @override
  Widget build(BuildContext context) {
    /// Spread radius
    /// The default is 1.0. To remove backgroud simply use elevation 0.
    double? _spreadRadius = (elevation ?? 1.0) * 1.0;

    /// Blur radius
    /// The default is 4.0. To remove blur radius simply use elevation 0
    double? _blurRadius = (elevation ?? 1.0) * 4.0;

    /// offset
    /// The default is 4.0. To remove offset simply use elevation 0
    double? _offSet = (elevation ?? 1.0) * 2;

    /// Leading content Flex
    /// The default is 2.
    /// Default : FlexGroup(2,3)
    int _leadingFlex = (flex ?? FlexGroup(2, 3)).leading;

    /// Trailing content Flex
    /// The default is 2.
    /// Default : FlexGroup(2,3)
    int _trailingFlex = (flex ?? FlexGroup(2, 3)).trailing;

    return Container(
      margin: boxMargin ?? EdgeInsets.zero,
      padding: boxPadding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? greyColor.withOpacity(0.3),
            spreadRadius: _spreadRadius,
            blurRadius: _blurRadius,
            offset: Offset(0, _offSet),
          )
        ],
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title With Button
          header ?? const SizedBox(),
          (header != null)
              ? (divider ??
                  Divider(
                    color: dividerColor ?? greyColor,
                    thickness: dividerThickness ?? 0.3,
                    height: 0,
                  ))
              : const SizedBox(),

          // Detailed Information
          Container(
            padding:
                contentPadding ?? const EdgeInsets.fromLTRB(25, 15, 25, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (title != null)
                    ? Text(
                        title!,
                        style: BoldTextStyle(blackColor, fontSize: 12),
                      )
                    : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: _leadingFlex,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: leading ?? [],
                      ),
                    ),
                    (trailing != null)
                        ? Flexible(
                            flex: _trailingFlex,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: trailing ?? [],
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          ...?bottom
        ],
      ),
    );
  }
}

/// Flex Group Class.
class FlexGroup {
  final int leading;
  final int trailing;

  FlexGroup(this.leading, this.trailing);
}
