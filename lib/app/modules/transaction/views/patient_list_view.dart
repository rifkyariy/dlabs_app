import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/global_widgets/app_single_button_slideable.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';
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
          'Patient List',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        semanticChildCount:
            (controller.transactionDetail.patientList ?? []).length,
        itemCount: (controller.transactionDetail.patientList ?? []).length,
        itemBuilder: (context, index) {
          return _singleButtonSlideable(
            title: (controller.transactionDetail.patientList ?? [])[index]
                    .fullName ??
                '',
            subtitle:
                'ID No : ${(controller.transactionDetail.patientList ?? [])[index].identityNumber ?? ''}',
          );
        },
      ),
    );
  }

  Widget _singleButtonSlideable({
    required String title,
    required String subtitle,
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
      buttonLabel: 'View Detail',
      isThreeLine: false,
      icon: AppIcons.article,
    );
  }
}