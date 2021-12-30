import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/data/services/app_converter.dart';
import 'package:dlabs_apps/app/data/services/currency_formatting.dart';

import 'package:dlabs_apps/app/global_widgets/app_detail_information_box.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_item.dart';
import 'package:dlabs_apps/app/global_widgets/app_single_button_slideable.dart';
import 'package:dlabs_apps/app/global_widgets/app_title_with_button.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrganizationTransactionDetailView
    extends GetView<TransactionViewController> {
  const OrganizationTransactionDetailView({Key? key}) : super(key: key);

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
          'Transaction Detail',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header Component
            _headerComponent(
              enabled:
                  controller.currentTransactionStatus == TRANSACTIONSTATUS.done
                      ? true
                      : false,
            ),

            /// App Detailed Box
            AppDetailInformationBox(
              header: AppTitleWithButton(
                title: AppConverter.transactionEnumToString(
                    controller.currentTransactionStatus),
                buttonLabel: 'View Status',
                onTap: () => {}, // Create onTap Handler
                titleColor: controller.currentTransactionStatus ==
                        TRANSACTIONSTATUS.canceled
                    ? dangerColor
                    : blackColor,
              ),
              title: 'Invoice for',
              leading: [
                _thinDetailInformationItem('PIC ID Number'),
                _thinDetailInformationItem('PIC Name'),
                _thinDetailInformationItem('PIC Email'),
                _thinDetailInformationItem('PIC Phone'),
              ],

              /// Trailing Button
              trailing: [
                _blackDetailInformationItem(
                    controller.transactionDetail.identityNumber ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.name ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.email ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.phone ?? ''),
              ],
            ),

            const SizedBox(height: 15),

            AppDetailInformationBox(
              header: AppTitleWithButton(
                title: 'Test Information',
                buttonLabel: 'View Detail',
                onTap: () {},
              ),

              /// Leading
              leading: [
                _thinDetailInformationItem('Test Purposes'),
                _thinDetailInformationItem('Test Date'),
                _thinDetailInformationItem('Service'),
                _thinDetailInformationItem('Location'),
              ],

              trailing: [
                _blackDetailInformationItem(
                    controller.transactionDetail.testPurpose ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.testDate ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.services ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.locationName ?? ''),
                _blackDetailInformationItem(
                    controller.transactionDetail.locationAddress ?? ''),
              ],

              /// Bottom Component
              bottom: [
                Divider(
                  color: greyColor,
                  thickness: 0.3,
                  height: 10,
                ),

                /// Disabled Button For Title Only
                AppTitleWithButton(
                  title:
                      controller.transactionDetail.masterMedicalKitNama ?? '',
                  buttonLabel: CurrencyFormat.convertToIdr(
                      controller.transactionDetail.price ?? 0, 2),
                  titleColor: primaryColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _thinDetailInformationItem(
                        DateFormat.yMMMMd('en_US').format(
                          DateTime.parse(
                            controller.transactionDetail.transactionDate ?? '',
                          ),
                        ),
                      ),
                      _thinDetailInformationItem(
                          '${(controller.transactionDetail.patientList ?? []).length} X')
                    ],
                  ),
                ),

                Divider(
                  color: greyColor,
                  thickness: 0.3,
                  height: 10,
                ),

                /// Disabled Button For Title Only
                AppTitleWithButton(
                  title: 'Total Price',
                  buttonLabel: CurrencyFormat.convertToIdr(
                      controller.transactionDetail.price ?? 0, 2),
                  titleColor: blackColor,
                  buttonLabelColor: blackColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
                ),
              ],
            ),
            const SizedBox(height: 15),

            AppDetailInformationBox(
              contentPadding: EdgeInsets.zero,
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Patient Information',
                buttonLabel: 'View All',
                onTap: controller.toPatientListScreen,
              ),
              bottom: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  semanticChildCount:
                      (controller.transactionDetail.patientList ?? []).length <
                              5
                          ? (controller.transactionDetail.patientList ?? [])
                              .length
                          : 5,
                  itemCount: (controller.transactionDetail.patientList ?? [])
                              .length <
                          5
                      ? (controller.transactionDetail.patientList ?? []).length
                      : 5,
                  itemBuilder: (context, index) {
                    return _singleButtonSlideable(
                      title: (controller.transactionDetail.patientList ??
                                  [])[index]
                              .fullName ??
                          '',
                      subtitle:
                          'ID No : ${(controller.transactionDetail.patientList ?? [])[index].identityNumber ?? ''}',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),
            AppDetailInformationBox(
              title: 'Payment Detail',
              leading: const [
                AppDetailInformationItem('Total Price'),
                AppDetailInformationItem('Payment Method'),
                AppDetailInformationItem('Payment Time'),
              ],
              trailing: [
                AppDetailInformationItem(
                  CurrencyFormat.convertToIdr(
                      controller.transactionDetail.price ?? 0, 2),
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'BCA',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  /// TODO change to payment date
                  controller.transactionDetail.transactionDate ?? '',
                  color: blackColor,
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),

      /// Bottom Button
      bottomNavigationBar: _bottomButtonComponent(
        offline:
            controller.currentTransactionStatus == TRANSACTIONSTATUS.canceled
                ? false
                : true,
      ),
    );
  }

  /// Bottom Button Component
  Widget _bottomButtonComponent({bool? offline}) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(height: 0, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: TextButton(
              /// If online then close if offline then fuck
              onPressed: offline ?? false
                  ? () {
                      /// If offline payment method, then download the payment proof
                    }
                  : () {
                      Get.back();
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    offline ?? false ? 'Proof of Payment' : 'Close',
                    style: regularTextStyle(
                        offline ?? false ? whiteColor : primaryColor),
                  ),
                  offline ?? false
                      ? const SizedBox(width: 15)
                      : const SizedBox(),
                  offline ?? false
                      ? Icon(AppIcons.download, color: whiteColor, size: 20)
                      : const SizedBox(),
                ],
              ),
              style: TextButton.styleFrom(
                primary: offline ?? false ? primaryColor : whiteColor,
                backgroundColor: offline ?? false ? primaryColor : whiteColor,
                minimumSize: const Size(double.infinity, 45),
                side: BorderSide(color: primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  /// Header Component
  Widget _headerComponent({bool? enabled}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Transaction ID Part
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.transactionDetail.transactionId ?? '',
                      style: BoldTextStyle(primaryColor, fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Organizational Service',
                      style: mediumTextStyle(blackColor, fontSize: 12),
                    )
                  ],
                ),
              ),

              // Invoice Button Part
              Column(
                children: [
                  IconButton(
                    enableFeedback: false,
                    onPressed: enabled ?? false
                        ? () {
                            controller.onInvoiceButtonPressed(
                              controller.transactionDetail.transactionId ?? '',
                            );
                          }
                        : null,
                    icon: Icon(
                      AppIcons.invoice,
                      color: enabled ?? false ? primaryColor : greyColor,
                    ),
                  ),
                  Text(
                    'Invoice',
                    style: BoldTextStyle(
                      enabled ?? false ? primaryColor : greyColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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

  AppDetailInformationItem _blackDetailInformationItem(String text) {
    return AppDetailInformationItem(
      text,
      color: blackColor,
    );
  }

  AppDetailInformationItem _thinDetailInformationItem(String text) {
    return AppDetailInformationItem(text);
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
