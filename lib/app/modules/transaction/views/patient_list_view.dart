import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/global_widgets/app_empty_state.dart';
import 'package:kayabe_lims/app/global_widgets/app_single_button_slideable.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPatientListView extends GetView<TransactionViewController> {
  const TransactionPatientListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
          'o_bt_patient_list'.tr,
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: (controller.transactionDetail.patientList ?? []).isEmpty
          ? AppEmptyStatePlaceholder(messages: 'tr_d_no_data'.tr)
          : ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 10, right: 10),

              shrinkWrap: true,
              semanticChildCount:
                  (controller.transactionDetail.patientList ?? []).length,
              itemCount:
                  (controller.transactionDetail.patientList ?? []).length,
              itemBuilder: (context, index) {
                return _singleButtonSlideable(
                  title: (controller.transactionDetail.patientList ?? [])[index]
                          .fullName ??
                      '',
                  subtitle:
                      '${"o_bt_id_number".tr} : ${(controller.transactionDetail.patientList ?? [])[index].identityNumber ?? ''} \n${"gen_test_type".tr} : ${(controller.transactionDetail.patientList ?? [])[index].testTypeText ?? ''} \n${"gen_phone".tr} : ${(controller.transactionDetail.patientList ?? [])[index].phone ?? ''} ',
                  onPressed: (context) async {
                    controller.onViewDetailButtonPressed(index);
                  },
                );
              },
            ),
    );
  }

  Widget _singleButtonSlideable({
    required String title,
    required String subtitle,
    Function(BuildContext)? onPressed,
  }) {
    return AppSingleButtonSlideable(
      leading: CircleAvatar(
        child: Text(
          title[0],
          style: BoldTextStyle(primaryColor, fontSize: 14),
        ),
        backgroundColor: lightGreyColor,
      ),
      title: Text(
        title,
        style: BoldTextStyle(blackColor, fontSize: 13),
      ),
      subtitle: Text(
        subtitle,
        style: mediumTextStyle(greyColor, fontSize: 12),
      ),
      buttonLabel: 'tr_d_view_detail'.tr,
      isThreeLine: true,
      icon: AppIcons.article,
      buttonPressed: onPressed,
    );
  }
}
