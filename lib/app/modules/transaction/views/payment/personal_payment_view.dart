import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_tracking_list.dart';
import 'package:kayabe_lims/app/data/services/app_converter.dart';
import 'package:kayabe_lims/app/data/services/currency_formatting.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_android_button.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_ios_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_box.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_item.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class PersonalPaymentView extends GetView<TransactionViewController> {
  const PersonalPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List trackingList = controller.transactionDetail.trackingList!
        .where((element) => element.status == 'Payment')
        .toList();

    TrxDetailTrackingList paymentList = trackingList.isNotEmpty
        ? trackingList.first
        : const TrxDetailTrackingList();

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
              title: 'Invoice for',
              header: AppTitleWithButton(
                title: AppConverter.transactionEnumToString(
                  controller.currentTransactionStatus,
                ),
                buttonLabel: 'View Status',
                onTap: () {
                  controller.toTrackingProcessView();
                },
                titleColor: controller.currentTransactionStatus ==
                        TRANSACTIONSTATUS.canceled
                    ? dangerColor
                    : blackColor,
              ),
              leading: [
                AppDetailInformationItem('Transaction Date'),
                AppDetailInformationItem('gen_identity_number'.tr),
                AppDetailInformationItem('gen_fullname'.tr),
                AppDetailInformationItem('Email'),
                AppDetailInformationItem('Phone'),
              ],

              /// Trailing Button
              trailing: [
                AppDetailInformationItem(
                  controller.transactionDetail.transactionDate ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.identityNumber ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.name ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.email ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.phone ?? '',
                  color: blackColor,
                ),
              ],
            ),

            const SizedBox(height: 15),

            AppDetailInformationBox(
              title: 'gen_test_information'.tr,
              leading:  [
                AppDetailInformationItem('gen_test_purpose'.tr),
                AppDetailInformationItem('Test Type'),
                AppDetailInformationItem('Test Date'),
                AppDetailInformationItem('Service'),
                AppDetailInformationItem('Location'),
              ],
              trailing: [
                AppDetailInformationItem(
                  controller.transactionDetail.testPurpose ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.masterMedicalKitNama ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.testDate ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.services ?? '',
                  color: blackColor,
                ),

                /// TODO change this if error
                AppDetailInformationItem(
                  controller.transactionDetail.locationName ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.transactionDetail.locationAddress ?? '',
                  color: blackColor,
                ),
              ],
            ),

            const SizedBox(height: 15),

            AppDetailInformationBox(
              title: (controller.transactionDetail.patientList ?? [])[0]
                      .fullName ??
                  '',
              header: AppTitleWithButton(
                title: 'Patient Information',
                buttonLabel: 'View Detail',
                onTap: controller.toPatientDetailScrenn,
              ),

              /// Leading
              leading: [
                AppDetailInformationItem(
                  (controller.transactionDetail.patientList ?? [])[0]
                          .identityNumber ??
                      '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  (controller.transactionDetail.patientList ?? [])[0].phone ??
                      '',
                  color: blackColor,
                ),
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
                  title: (controller.transactionDetail.patientList ?? [])[0]
                          .testTypeText ??
                      '',
                  buttonLabel: CurrencyFormat.convertToIdr(
                    (controller.transactionDetail.price ?? 0),
                    2,
                  ),
                  titleColor: primaryColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                  child: AppDetailInformationItem(
                    DateFormat.yMMMMd('en_US').format(
                      DateTime.parse(
                          (controller.transactionDetail.patientList ?? [])[0]
                                  .createdDate ??
                              ''),
                    ),
                    color: greyColor,
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
                    (controller.transactionDetail.price ?? 0),
                    2,
                  ),
                  titleColor: blackColor,
                  buttonLabelColor: blackColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
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
                  //   controller.selectedPaymentMethodName.value,
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
                    }, // TODO
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
                    }, // TODO
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
                      'Personal Service',
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
}
