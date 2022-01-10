import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TransactionTimelineTrackingHorizontal extends StatelessWidget {
  TransactionTimelineTrackingHorizontal({
    Key? key,
    this.processIndex = 0,
  }) : super(key: key);

  final int processIndex;

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        direction: Axis.horizontal,
        connectorTheme: const ConnectorThemeData(space: 30.0, thickness: 3.0),
      ),
      builder: TimelineTileBuilder.connected(
        // Jumlah indicator nya (bundaran2 nya)
        itemCount: 4,

        // Ini seberapa lebar spasi antara bundaranya
        itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / 4,

        // Content di atas bundaran
        oppositeContentsBuilder: (context, index) => const SizedBox(),

        // Content di bawah bundaran
        contentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              _processList[index],
              style: mediumTextStyle(_getColor(index), fontSize: 12),
            ),
          );
        },

        // Ini bundaranya
        indicatorBuilder: (_, index) {
          if (index <= processIndex) {
            return OutlinedDotIndicator(
              size: 50,
              color: completeColor,
              child: Icon(
                _getIcons(index),
                color: completeColor,
                size: 25,
              ),
            );
          } else {
            return OutlinedDotIndicator(
              size: 50,
              color: todoColor,
              child: Icon(
                _getIcons(index),
                color: todoColor,
                size: 25,
              ),
            );
          }
        },

        // Ini garisnya
        connectorBuilder: (_, index, type) {
          if (index <= processIndex) {
            return SolidLineConnector(
              color: _getColor(index),
            );
          } else {
            return SolidLineConnector(
              color: _getColor(index),
            );
          }
        },
      ),
    );
  }

  IconData _getIcons(int index) {
    switch (index) {
      case 0:
        return AppIcons.creditCard;
      case 1:
        return AppIcons.labBottle;
      case 2:
        return AppIcons.files;
      case 3:
        return AppIcons.filesDone;
      default:
        return AppIcons.creditCard;
    }
  }

  Color _getColor(int index) {
    if (index <= processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  final _processList = [
    'Payment',
    'Lab Process',
    'Release Result',
    'Done',
  ];

  final completeColor = primaryColor;
  final inProgressColor = const Color(0xff5ec792);
  final todoColor = const Color(0xffd1d2d7);
}
