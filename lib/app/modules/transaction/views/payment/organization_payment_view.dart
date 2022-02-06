import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_tracking_list.dart';
import 'package:kayabe_lims/app/data/services/app_converter.dart';
import 'package:kayabe_lims/app/data/services/currency_formatting.dart';

import 'package:kayabe_lims/app/global_widgets/app_detail_information_box.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_item.dart';
import 'package:kayabe_lims/app/global_widgets/app_single_button_slideable.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_android_button.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_ios_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrganizationPaymentView extends GetView<TransactionViewController> {
  const OrganizationPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List trackingList = controller.transactionDetail.trackingList!
        .where((element) => element.status == 'Payment')
        .toList();

    TrxDetailTrackingList paymentList = trackingList.isNotEmpty
        ? trackingList.first
        : const TrxDetailTrackingList();

    print(paymentList);

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
            _headerComponent(enabled: true),

            /// App Detailed Box
            AppDetailInformationBox(
              header: AppTitleWithButton(
                title: AppConverter.transactionEnumToString(
                    controller.currentTransactionStatus),
                buttonLabel: 'View Status',
                onTap: () {
                  controller.toTrackingProcessView();
                }, // Create onTap Handler
                titleColor: controller.currentTransactionStatus ==
                        TRANSACTIONSTATUS.canceled
                    ? dangerColor
                    : blackColor,
              ),
              title: 'Invoice for',
              leading: [
                _thinDetailInformationItem('Transaction Date'),
                _thinDetailInformationItem('Identity Number'),
                _thinDetailInformationItem('Fullname'),
                _thinDetailInformationItem('Email'),
                _thinDetailInformationItem('Phone'),
              ],

              /// Trailing Button
              trailing: [
                _blackDetailInformationItem(
                    controller.transactionDetail.transactionDate ?? ''),
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
                buttonLabel: '',
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
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 10, right: 10),
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
                          'ID No : ${(controller.transactionDetail.patientList ?? [])[index].identityNumber ?? ''} \nTest Type : ${(controller.transactionDetail.patientList ?? [])[index].testTypeText ?? ''} ',
                      onPressed: (context) async {
                        await controller.onViewDetailButtonPressed(index);
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),
            Obx(
              () => AppDetailInformationBox(
                header: AppTitleWithButton(
                  title: 'Payment Detail',
                  buttonLabel: 'Choose',
                  onTap: () {
                    Get.dialog(
                      GetPlatform.isIOS ? _iosDialog() : _androidDialog(),
                    );
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                    size: 14,
                  ),
                ),
                leading: const [
                  AppDetailInformationItem('Total Price'),
                  // AppDetailInformationItem('Payment Method'),
                  AppDetailInformationItem('Payment Time'),
                ],
                trailing: [
                  AppDetailInformationItem(
                    CurrencyFormat.convertToIdr(
                      (controller.transactionDetail.price ?? 0),
                      2,
                    ),
                    color: blackColor,
                  ),
                  // AppDetailInformationItem(
                  //   'BCA',
                  //   color: blackColor,
                  // ),

                  AppDetailInformationItem(controller.paidDate.value),
                ],
                bottom: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: AppDetailInformationItem(
                        'Please make payment before the due date. Payment will be canceled automatically after 24 hours.'),
                  ),
                  SizedBox(height: 20)
                ],
              ),
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
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Divider(height: 0, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Total Price : ',
                  style: mediumTextStyle(blackColor, fontSize: 12),
                ),
                Text(
                  CurrencyFormat.convertToIdr(
                      (controller.transactionDetail.price ?? 0), 2),
                  style: BoldTextStyle(primaryColor, fontSize: 12),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: TransactionTextButton(
                    title: "Cancel",
                    isRedBackground: true,
                    onPressed: () {
                      Get.dialog(
                        GetPlatform.isIOS
                            ? _iosDialog(cancelDialog: true)
                            : _androidDialog(cancelDialog: true),
                      );
                    }, // TODO Cacel ASW
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 4,
                  child: TransactionTextButton(
                    title: "Pay",
                    isWhiteBackground: false,
                    onPressed: () {
                      Get.dialog(
                        GetPlatform.isIOS ? _iosDialog() : _androidDialog(),
                      );
                    }, //
                  ),
                ),
              ],
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
      buttonLabel: 'View Detail',
      isThreeLine: true,
      icon: AppIcons.article,
      buttonPressed: onPressed,
    );
  }

  Widget _androidDialog({bool cancelDialog = false}) {
    return SimpleDialog(
      title: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cancelDialog ? "Warning!" : "Payment Option",
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              cancelDialog
                  ? "Are you sure want to cancel this transaction?"
                  : "Please select a payment method",
              style: regularTextStyle(
                blackColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      children: cancelDialog
          ? [
              TransactionTextButton(
                title: 'Yes',
                isWhiteBackground: false,
                onPressed: () async {
                  Get.back();
                  await controller.onCancelTransactionButtonPressed(
                    controller.transactionDetail.transactionId ?? '',
                  );
                },
              ),
              const SizedBox(height: 15),
              TransactionTextButton(
                title: 'No',
                isWhiteBackground: true,
                onPressed: () {
                  Get.back();
                },
              )
            ]
          : [
              TransactionTextButton(
                title: 'Transfer',
                isWhiteBackground: true,
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toOfflinePayment();
                },
              ),
              const SizedBox(height: 15),
              TransactionTextButton(
                title: 'Cash',
                isWhiteBackground: true,
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toCashPayment();
                },
              ),
              const SizedBox(height: 15),
              TransactionTextButton(
                title: 'Online',
                isWhiteBackground: true,
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();
                },
              )
            ],
    );
  }

  Widget _iosDialog({bool cancelDialog = false}) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.only(top: 24),
      backgroundColor: const Color(0xC7FBFBFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              cancelDialog ? "Warning!" : "Payment Option",
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              cancelDialog
                  ? "Are you sure want to cancel this transaction?"
                  : "Please select a payment method",
              style: regularTextStyle(
                blackColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      children: cancelDialog
          ? [
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'Yes',
                onPressed: cancelDialog ? () {} : () {},
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'No',
                onPressed: () async {
                  await controller.onCancelTransactionButtonPressed(
                    controller.transactionDetail.transactionId ?? '',
                  );
                },
              )
            ]
          : [
              TransactionIosButton(
                title: 'Transfer',
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toOfflinePayment();
                },
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'Cash',
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toCashPayment();
                },
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'Online',
                onPressed: () {},
              ),
            ],
    );
  }
}
