import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_empty_state.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalQuestionnarieView extends GetView<TransactionViewController> {
  const MedicalQuestionnarieView({Key? key}) : super(key: key);

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
          'Medical Questionnaire',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: (controller.medicalQuestionnaireList ?? []).isEmpty
          ? const AppEmptyStatePlaceholder(
              messages: 'There is no medical questionnaire data')
          : ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10),
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: false,
              semanticChildCount:
                  (controller.medicalQuestionnaireList ?? []).length,
              itemCount: (controller.medicalQuestionnaireList ?? []).length,
              itemBuilder: (context, index) {
                return _listTile(
                  title: (controller.medicalQuestionnaireList ?? [])[index]
                          .questionnaire ??
                      '',
                  subtitle: (controller.medicalQuestionnaireList ?? [])[index]
                          .jawaban ??
                      '',
                );
              },
            ),
    );
  }

  Widget _listTile({required String title, required String subtitle}) {
    return ListTile(
      title: Text(
        title,
        style: BoldTextStyle(blackColor, fontSize: 12),
      ),
      subtitle: Text(
        subtitle,
        style: mediumTextStyle(greyColor, fontSize: 12),
      ),
    );
  }
}
