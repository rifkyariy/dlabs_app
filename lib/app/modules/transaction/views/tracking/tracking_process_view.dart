import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:dlabs_apps/app/modules/transaction/local_widgets/transaction_timeline_tracking_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackingProcessView extends GetView<TransactionViewController> {
  const TrackingProcessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 2.0,
        backgroundColor: Colors.white,
        shadowColor: lightGreyColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: const Color(0xFF1176BC),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tracking Process',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
              child: TransactionTimelineTrackingHorizontal(
                processIndex: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
