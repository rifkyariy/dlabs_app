import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_box.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_item.dart';
import 'package:kayabe_lims/app/global_widgets/app_empty_state.dart';
import 'package:kayabe_lims/app/global_widgets/app_single_button_slideable.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';

class OrganizationTransactionPatientInformationView
    extends GetView<TransactionViewController> {
  const OrganizationTransactionPatientInformationView(
      {Key? key, required this.index})
      : super(key: key);

  final int index;

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
            // TODO patient info yang lama
            // /// Patient information
            // AppDetailInformationBox(
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   shadowColor: Colors.transparent,
            //   flex: FlexGroup(3, 2),
            //   leading: controller.isHomeService()
            //       ? [
            //           _boldDetailInformationItem('Nationality'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .nationality ??
            //                   ''),
            //           _boldDetailInformationItem('Fullname'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .fullName ??
            //                   ''),
            //           _boldDetailInformationItem('Email'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .email ??
            //                   ''),
            //           _boldDetailInformationItem('Location'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .address ??
            //                   ''),
            //         ]
            //       : [
            //           ///
            //           /// Left Part of the table
            //           /// Consist of title and Information
            //           ///
            //           _boldDetailInformationItem('Nationality'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .nationality ??
            //                   ''),
            //           _boldDetailInformationItem('Identity Number'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .identityNumber ??
            //                   ''),
            //           _boldDetailInformationItem('Fullname'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .fullName ??
            //                   ''),
            //           _boldDetailInformationItem('Email'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .email ??
            //                   ''),
            //         ],
            //   trailing: controller.isHomeService()
            //       ? [
            //           _boldDetailInformationItem('Date of birth'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .birthDate ??
            //                   ''),
            //           _boldDetailInformationItem('Identity Number'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .identityNumber ??
            //                   ''),
            //           _boldDetailInformationItem('Gender'),
            //           _mediumDetailInformationItem(
            //             ((controller.transactionDetail.patientList ?? [])[0]
            //                             .gender ??
            //                         '') ==
            //                     '1'
            //                 ? "Male"
            //                 : "Female",
            //           ),
            //           _boldDetailInformationItem('Phone'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .phone ??
            //                   ''),
            //         ]
            //       : [
            //           ///
            //           /// Right Side of the table
            //           /// Consist of title and information
            //           ///
            //           _boldDetailInformationItem('Date of birth'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .birthDate ??
            //                   ''),
            //           _boldDetailInformationItem('Gender'),
            //           _mediumDetailInformationItem(
            //             ((controller.transactionDetail.patientList ?? [])[0]
            //                             .gender ??
            //                         '') ==
            //                     '1'
            //                 ? "Male"
            //                 : "Female",
            //           ),
            //           _boldDetailInformationItem('Phone'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.patientList ?? [])[0]
            //                       .phone ??
            //                   ''),
            //           _boldDetailInformationItem('Location'),
            //           _mediumDetailInformationItem(
            //               (controller.transactionDetail.locationName ?? '')),
            //         ],
            // ),

            /// Patient information
            AppDetailInformationBox(
              contentPadding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              flex: FlexGroup(3, 2),
              leading: controller.isHomeService()
                  ? [
                      _boldDetailInformationItem('Nationality'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .nationality ??
                              ''),
                      _boldDetailInformationItem('Fullname'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .fullName ??
                              ''),
                      _boldDetailInformationItem('Email'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .email ??
                              ''),
                      _boldDetailInformationItem('Location'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .address ??
                              ''),
                    ]
                  : [
                      ///
                      /// Left Part of the table
                      /// Consist of title and Information
                      ///
                      _boldDetailInformationItem('Nationality'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .nationality ??
                              ''),
                      _boldDetailInformationItem('Identity Number'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .identityNumber ??
                              ''),
                      _boldDetailInformationItem('Fullname'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .fullName ??
                              ''),
                      _boldDetailInformationItem('Email'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .email ??
                              ''),
                    ],
              trailing: controller.isHomeService()
                  ? [
                      _boldDetailInformationItem('Date of birth'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .birthDate ??
                              ''),
                      _boldDetailInformationItem('Identity Number'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .identityNumber ??
                              ''),
                      _boldDetailInformationItem('Gender'),
                      _mediumDetailInformationItem(
                        ((controller.transactionDetail.patientList ?? [])[index]
                                        .gender ??
                                    '') ==
                                '1'
                            ? "Male"
                            : "Female",
                      ),
                      _boldDetailInformationItem('Phone'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .phone ??
                              ''),
                    ]
                  : [
                      ///
                      /// Right Side of the table
                      /// Consist of title and information
                      ///
                      _boldDetailInformationItem('Date of birth'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .birthDate ??
                              ''),
                      _boldDetailInformationItem('Gender'),
                      _mediumDetailInformationItem(
                        ((controller.transactionDetail.patientList ?? [])[index]
                                        .gender ??
                                    '') ==
                                '1'
                            ? "Male"
                            : "Female",
                      ),
                      _boldDetailInformationItem('Phone'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.patientList ??
                                      [])[index]
                                  .phone ??
                              ''),
                      _boldDetailInformationItem('Location'),
                      _mediumDetailInformationItem(
                          (controller.transactionDetail.locationName ?? '')),
                    ],
            ),

            /// Adress
            /// Separated because of flex
            controller.isHomeService()
                ? const SizedBox()
                : AppDetailInformationBox(
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
                        (controller.transactionDetail.patientList ?? [])[0]
                                .address ??
                            '',
                        padding: const EdgeInsets.only(top: 5),
                        style: mediumTextStyle(blackColor, fontSize: 13),
                      ),
                    ],
                  ),

            // Test Information
            AppDetailInformationBox(
                contentPadding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
                divider: const SizedBox(),
                header: AppTitleWithButton(
                  title: 'Test Information',
                  buttonLabel: '',
                  titleColor: primaryColor,
                  onTap: controller.toMedicalHistoryListView,
                ),
                flex: FlexGroup(3, 2),
                leading: [
                  _boldDetailInformationItem('Test Purpose'),
                  _mediumDetailInformationItem(
                      controller.transactionDetail.testPurpose ?? ''),
                  _boldDetailInformationItem('Test Date'),
                  _mediumDetailInformationItem(
                      controller.transactionDetail.testDate ?? ''),
                  _boldDetailInformationItem('Arrived Date'),
                  _mediumDetailInformationItem((controller
                              .transactionDetail.patientList![0].arrivedDate !=
                          '')
                      ? controller
                          .transactionDetail.patientList![0].arrivedDate!
                      : '-'),
                ],
                trailing: [
                  _boldDetailInformationItem('Test Type'),
                  _mediumDetailInformationItem(
                      (controller.transactionDetail.patientList ?? [])[index]
                              .testTypeText ??
                          ''),
                  _boldDetailInformationItem('Service'),
                  _mediumDetailInformationItem(
                      controller.transactionDetail.services ?? '')
                ]),

            /// Adress
            /// Separated because of flex
            controller.isHomeService()
                ? const SizedBox()
                : AppDetailInformationBox(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    leading: [
                      AppDetailInformationItem(
                        'Location',
                        style: BoldTextStyle(blackColor, fontSize: 13),
                      ),
                      AppDetailInformationItem(
                        ('${controller.transactionDetail.locationName ?? ""} \n${controller.transactionDetail.locationAddress ?? ""}'),
                        padding: const EdgeInsets.only(top: 5),
                        style: mediumTextStyle(blackColor, fontSize: 13),
                      ),
                    ],
                  ),

            const SizedBox(height: 15),

            /// Medical History
            ///
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              boxMargin: const EdgeInsets.only(top: 20),
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Test Result',
                buttonLabel: 'View All',
                titleColor: primaryColor,
                onTap: controller.toMedicalHistoryListView,
              ),
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                    elevation: controller.medicalHistoryList!.isEmpty ? 0 : 2,
                    shadowColor: controller.medicalHistoryList!.isEmpty
                        ? Colors.transparent
                        : lightGreyColor,
                    color: controller.medicalHistoryList!.isEmpty
                        ? Colors.transparent
                        : whiteColor,
                    margin: EdgeInsets.zero,
                    child: (controller.medicalHistoryList ?? []).isEmpty
                        ? const AppEmptyStatePlaceholder(
                            messages: 'There is no test result data',
                            medical: true,
                            maximumSize: Size(200, 150),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            semanticChildCount:
                                (controller.medicalHistoryList ?? []).length < 3
                                    ? (controller.medicalHistoryList ?? [])
                                        .length
                                    : 3,
                            itemCount:
                                (controller.medicalHistoryList ?? []).length < 3
                                    ? (controller.medicalHistoryList ?? [])
                                        .length
                                    : 3,
                            itemBuilder: (context, index) {
                              if (controller.medicalHistoryList != null) {
                                return _testResultCard(
                                  sampleID:
                                      '${controller.medicalHistoryList![index].sampleId}',
                                  sampleType:
                                      '${controller.medicalHistoryList![index].sampleType}',
                                  status: controller
                                      .medicalHistoryList![index].result!,
                                  messages:
                                      '${controller.medicalHistoryList![index].noteResult}',
                                  onPressed: () {
                                    controller.onDownloadButtonPressed(
                                        controller.medicalHistoryList![index]
                                                .sampleFile ??
                                            '');
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                  ),
                ),
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
