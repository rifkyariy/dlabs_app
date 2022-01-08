import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
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
        itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / 4,

        // Content di atas bundaran
        oppositeContentsBuilder: (context, index) => const SizedBox(),

        // Content di bawah bundaran
        contentsBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              _processList[index],
              style: mediumTextStyle(getColor(index), fontSize: 12),
            ),
          );
        },

        // Ini bundaranya
        indicatorBuilder: (_, index) {
          Color color;
          Widget child;

          if (index <= processIndex) {
            color = completeColor;
            child = Icon(
              _getIcons(index),
              color: primaryColor,
              size: 25,
            );
          } else {
            color = todoColor;
            child = Icon(
              _getIcons(index),
              color: todoColor,
              size: 25,
            );
          }

          if (index <= processIndex) {
            return OutlinedDotIndicator(
              size: 50,
              color: color,
              child: child,
            );
          } else {
            return OutlinedDotIndicator(
              size: 50,
              color: color,
              child: child,
            );
          }
        },

        // Ini garisnya
        connectorBuilder: (_, index, type) {
          if (index <= processIndex) {
            return SolidLineConnector(
              color: getColor(index),
            );
          } else {
            return SolidLineConnector(
              color: getColor(index),
            );
          }
        },
        itemCount: 4,
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

  Color getColor(int index) {
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
