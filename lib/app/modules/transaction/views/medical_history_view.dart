import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_empty_state.dart';
import 'package:kayabe_lims/app/global_widgets/app_single_button_slideable.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalHistoryView extends GetView<TransactionViewController> {
  const MedicalHistoryView({Key? key}) : super(key: key);

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
          'Medical History',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: (controller.medicalHistoryList ?? []).isEmpty
          ? const AppEmptyStatePlaceholder(
              messages: 'There is no medical history data',
            )
          : ListView.builder(
              itemCount: (controller.medicalHistoryList ?? []).length,
              itemBuilder: (context, index) {
                if (controller.medicalHistoryList != null) {
                  return _singleButtonSlideable(
                    title:
                        'Sample ${index + 1} • ${controller.medicalHistoryList![index].sampleType}',
                    subtitle:
                        '${controller.medicalHistoryList![index].noteResult}',
                    trailing: controller.medicalHistoryList![index].result!
                        .split('/')
                        .first,
                    buttonPressed: (context) {
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

  Widget _singleButtonSlideable({
    required String title,
    required String subtitle,
    required String trailing,
    Function(BuildContext)? buttonPressed,
  }) {
    return AppSingleButtonSlideable(
      title: Text(
        title,
        style: BoldTextStyle(blackColor, fontSize: 12),
      ),
      subtitle: Text(
        subtitle,
        style: mediumTextStyle(greyColor, fontSize: 12),
      ),
      trailing: Text(
        trailing,
        style: mediumTextStyle(primaryColor, fontSize: 12),
      ),
      buttonLabel: 'Download',
      isThreeLine: true,
      buttonPressed: buttonPressed,
    );
  }
}
