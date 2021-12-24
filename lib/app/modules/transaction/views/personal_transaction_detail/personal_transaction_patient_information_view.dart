import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_box.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_item.dart';
import 'package:dlabs_apps/app/global_widgets/app_single_button_slideable.dart';
import 'package:dlabs_apps/app/global_widgets/app_title_with_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';

class PersonalTransactionPatientInformationView
    extends GetView<TransactionViewController> {
  const PersonalTransactionPatientInformationView({Key? key}) : super(key: key);

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
          'Patient Information',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Patient information
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              flex: FlexGroup(3, 2),
              leading: [
                ///
                /// Left Part of the table
                /// Consist of title and Information
                ///
                _boldDetailInformationItem('Nationality'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0]
                            .nationality ??
                        ''),
                _boldDetailInformationItem('Identity Number'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0]
                            .identityNumber ??
                        ''),
                _boldDetailInformationItem('Full Name'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0]
                            .fullName ??
                        ''),
                _boldDetailInformationItem('Email'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0].email ??
                        ''),
              ],
              trailing: [
                ///
                /// Right Side of the table
                /// Consist of title and information
                ///
                _boldDetailInformationItem('Date of birth'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0]
                            .birthDate ??
                        ''),
                _boldDetailInformationItem('Gender'),
                _mediumDetailInformationItem(
                    ((controller.transactionDetail.patientList ?? [])[0]
                                    .gender ??
                                '') ==
                            '1'
                        ? "Male"
                        : "Female"),
                _boldDetailInformationItem('Phone'),
                _mediumDetailInformationItem(
                    (controller.transactionDetail.patientList ?? [])[0].phone ??
                        ''),
                _boldDetailInformationItem('Location'),

                /// TODO make this dynamic
                // _mediumDetailInformationItem(''),
              ],
            ),

            /// Adress
            /// Separated because of flex
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
              leading: [
                AppDetailInformationItem(
                  'Address',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  (controller.transactionDetail.patientList ?? [])[0].address ??
                      '',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
              ],
            ),

            /// Medical Questionaire
            ///

            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              boxMargin: const EdgeInsets.only(top: 20),
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Medical Questionnaire',
                buttonLabel: 'View All',
                titleColor: primaryColor,
                onTap: controller.toMedicalQuestionnaireListView,
              ),
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      semanticChildCount:
                          (controller.medicalQuestionnaireList ?? []).length < 3
                              ? (controller.medicalQuestionnaireList ?? [])
                                  .length
                              : 3,
                      itemCount:
                          (controller.medicalQuestionnaireList ?? []).length < 3
                              ? (controller.medicalQuestionnaireList ?? [])
                                  .length
                              : 3,
                      itemBuilder: (context, index) {
                        return _listTile(
                          title:
                              (controller.medicalQuestionnaireList ?? [])[index]
                                      .questionnaire ??
                                  '',
                          subtitle:
                              (controller.medicalQuestionnaireList ?? [])[index]
                                      .jawaban ??
                                  '',
                        );
                      },
                    ),
                  ),
                )
              ],
            ),

            /// Medical History
            ///
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              boxMargin: const EdgeInsets.only(top: 20),
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Medical History',
                buttonLabel: 'View All',
                titleColor: primaryColor,
                onTap: () {},
              ),
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        /// Questionaire list

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
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
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

  AppDetailInformationItem _boldDetailInformationItem(String text) {
    return AppDetailInformationItem(
      text,
      padding: const EdgeInsets.only(top: 10),
      style: BoldTextStyle(blackColor, fontSize: 13),
    );
  }

  AppDetailInformationItem _mediumDetailInformationItem(String text) {
    return AppDetailInformationItem(
      text,
      padding: const EdgeInsets.only(top: 2),
      style: mediumTextStyle(blackColor, fontSize: 13),
    );
  }
}
