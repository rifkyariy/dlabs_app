import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/services/app_converter.dart';
import 'package:kayabe_lims/app/global_widgets/app_empty_state.dart';
import 'package:kayabe_lims/app/global_widgets/app_single_button_slideable.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalHistoryView extends GetView<TransactionViewController> {
  const MedicalHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TRANSACTIONSTATUS _status = AppConverter.transactionStatusToEnum(
        controller.transactionDetail.trackingList![0].status ?? "");

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
          'Test Result',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: (controller.medicalHistoryList ?? []).isEmpty ||
              _status == TRANSACTIONSTATUS.readyToRelease
          ? const AppEmptyStatePlaceholder(
              messages: 'There is no test result data',
            )
          : ListView.builder(
              itemCount: (controller.medicalHistoryList ?? []).length,
              itemBuilder: (context, index) {
                if (controller.medicalHistoryList != null) {
                  return _testResultCard(
                    sampleID:
                        '${controller.medicalHistoryList![index].sampleId}',
                    sampleType:
                        '${controller.medicalHistoryList![index].sampleType}',
                    status: controller.medicalHistoryList![index].result!,
                    messages:
                        '${controller.medicalHistoryList![index].noteResult}',
                    onPressed: () {
                      controller.onDownloadButtonPressed(
                          controller.medicalHistoryList![index].sampleFile ??
                              '');
                    },
                  );
                }

                return const SizedBox();
              },
            ),
    );
  }

  Widget _testResultCard({
    required String sampleID,
    required String sampleType,
    required String status,
    required String messages,
    Function()? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 13, bottom: 13, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sampleID,
                    style: regularTextStyle(blackColor, fontSize: 10),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    sampleType,
                    style: BoldTextStyle(blackColor, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    status,
                    style: BoldTextStyle(primaryColor, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    messages,
                    style: regularTextStyle(blackColor, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                      minHeight: 30,
                      maxWidth: 2,
                      minWidth: 1,
                    ),
                    child: const VerticalDivider(),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: onPressed,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            AppIcons.download,
                            color: primaryColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Result',
                            style: regularTextStyle(primaryColor, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
