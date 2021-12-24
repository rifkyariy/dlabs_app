import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/app_single_button_slideable.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';
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
      body: ListView(
        children: [
          _singleButtonSlideable(
            title: 'Sample 1 • Swab PCR',
            subtitle:
                'Take care of your health by taking vitamins and drugs that the doctor has given.',
            trailing: 'Positif',
          ),
          _singleButtonSlideable(
            title: 'Sample 1 • Swab PCR',
            subtitle:
                'Take care of your health by taking vitamins and drugs that the doctor has given.',
            trailing: 'Positif',
          ),
          _singleButtonSlideable(
            title: 'Sample 1 • Swab PCR',
            subtitle:
                'Take care of your health by taking vitamins and drugs that the doctor has given.',
            trailing: 'Positif',
          ),
          _singleButtonSlideable(
            title: 'Sample 1 • Swab PCR',
            subtitle:
                'Take care of your health by taking vitamins and drugs that the doctor has given.',
            trailing: 'Positif',
          ),
        ],
      ),
    );
  }

  Widget _singleButtonSlideable({
    required String title,
    required String subtitle,
    required String trailing,
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
    );
  }
}
