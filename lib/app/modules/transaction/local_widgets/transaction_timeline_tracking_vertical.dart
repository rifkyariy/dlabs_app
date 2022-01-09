import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_tracking_list.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

class TransactionTimelineTrackingVertical
    extends GetView<TransactionViewController> {
  TransactionTimelineTrackingVertical({
    Key? key,
    required this.trackingList,
  }) : super(key: key);

  final List<TrxDetailTrackingList> trackingList;

  @override
  Widget build(BuildContext context) {
    final _processList = trackingList;
    return Timeline.tileBuilder(
      padding: const EdgeInsets.symmetric(vertical: 50),
      semanticChildCount: _processList.length,
      theme: TimelineThemeData(
        direction: Axis.vertical,
        connectorTheme: const ConnectorThemeData(
          space: 30.0,
          thickness: 1.0,
        ),
        nodePosition: 0.05,
        indicatorPosition: 0.05,
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.after,

        itemExtent: 75,

        // Content di samping bundaran
        contentsBuilder: (context, index) {
          return SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _processList[index].status ?? '',
                        style: BoldTextStyle(
                          (((_processList[index].status ?? '') == 'Cancel') ||
                                  (_processList[index].status ?? '') ==
                                      'Payment Rejected')
                              ? dangerColor
                              : getColor(index),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '- ${_processList[index].updatedDate ?? ''}',
                        style: BoldTextStyle(
                          index == 0 ? blackColor : todoColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _processList[index].message ?? '',
                    style: regularTextStyle(
                      index == 0 ? blackColor : todoColor,
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
          );
        },

        // Ini bundaranya
        indicatorBuilder: (_, index) {
          if (index == 0) {
            return DotIndicator(
              size: 10,
              color: (((_processList[index].status ?? '') == 'Cancel') ||
                      (_processList[index].status ?? '') == 'Payment Rejected')
                  ? dangerColor
                  : completeColor,
            );
          } else {
            return DotIndicator(
              size: 10,
              color: todoColor,
            );
          }
        },

        // Ini garisnya
        connectorBuilder: (_, index, type) {
          if (index == 0) {
            return SolidLineConnector(
              color: getColor(index),
            );
          } else {
            return SolidLineConnector(
              color: getColor(index),
            );
          }
        },
        itemCount: _processList.length,
      ),
    );
  }

  Color getColor(int index) {
    if (index == 0) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  final completeColor = primaryColor;
  final inProgressColor = const Color(0xff5ec792);
  final todoColor = const Color(0xffd1d2d7);
}
