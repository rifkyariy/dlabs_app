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
          'tr_d_transaction_detail'.tr,
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
              title: 'tr_d_invoice_for'.tr,
              header: AppTitleWithButton(
                title: AppConverter.transactionEnumToString(
                  controller.currentTransactionStatus,
                ),
                buttonLabel: 'tr_d_view_status'.tr,
                onTap: () {
                  controller.toTrackingProcessView();
                },
                titleColor: controller.currentTransactionStatus ==
                        TRANSACTIONSTATUS.canceled
                    ? dangerColor
                    : blackColor,
              ),
              leading: [
                AppDetailInformationItem('tr_d_transaction_date'.tr),
                AppDetailInformationItem('gen_identity_number_short'.tr),
                AppDetailInformationItem('gen_fullname'.tr),
                AppDetailInformationItem('gen_email'.tr),
                AppDetailInformationItem('gen_phone'.tr),
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
              leading: [
                AppDetailInformationItem('gen_test_purpose'.tr),
                AppDetailInformationItem('gen_test_type'.tr),
                AppDetailInformationItem('gen_test_date'.tr),
                AppDetailInformationItem('p_bt_service'.tr),
                AppDetailInformationItem('gen_arrived_date'.tr),
                AppDetailInformationItem('gen_location'.tr),
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
                AppDetailInformationItem(
                  (controller.transactionDetail.patientList![0].arrivedDate !=
                          '')
                      ? controller
                          .transactionDetail.patientList![0].arrivedDate!
                      : '-',
                  color: blackColor,
                ),
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
                title: 'gen_patient_information'.tr,
                buttonLabel: 'tr_d_view_detail'.tr,
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
                  title: 'gen_total_price'.tr,
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
                  title: 'tr_d_payment_detail'.tr,
                  buttonLabel: 'tr_d_choose'.tr,
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
                leading: [
                  AppDetailInformationItem('gen_total_price'.tr),
                  // AppDetailInformationItem('Payment Method'),
                  AppDetailInformationItem('tr_d_payment_time'.tr),
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
                bottom: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: AppDetailInformationItem('tr_d_caution_messages'.tr),
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
                  '${"gen_total_price".tr} : ',
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
                    title: "pop_cancel".tr,
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
                    title: "tr_d_pay".tr,
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
              cancelDialog ? "pop_warning".tr : "pop_payment_option".tr,
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              cancelDialog
                  ? "pop_cancel_transcation".tr
                  : "pop_select_payment".tr,
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
                title: 'gen_yes'.tr,
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
                title: 'gen_no'.tr,
                isWhiteBackground: true,
                onPressed: () {
                  Get.back();
                },
              )
            ]
          : [
              TransactionTextButton(
                title: 'gen_transfer'.tr,
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
                title: 'gen_cash'.tr,
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
                title: 'gen_online'.tr,
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
              cancelDialog ? "pop_warning".tr : "pop_payment_option".tr,
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              cancelDialog
                  ? "pop_cancel_transcation".tr
                  : "pop_select_payment".tr,
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
                title: 'gen_yes'.tr,
                onPressed: cancelDialog ? () {} : () {},
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'gen_no'.tr,
                onPressed: () async {
                  await controller.onCancelTransactionButtonPressed(
                    controller.transactionDetail.transactionId ?? '',
                  );
                },
              )
            ]
          : [
              TransactionIosButton(
                title: 'gen_transfer'.tr,
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toOfflinePayment();
                },
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'gen_cash'.tr,
                onPressed: () {
                  // Destroy Dialog Modal
                  Get.back();

                  // Redirect into offline payment method
                  controller.toCashPayment();
                },
              ),
              const Divider(height: 0, thickness: 1),
              TransactionIosButton(
                title: 'gen_online'.tr,
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
                      'tr_d_personal_service'.tr,
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
                    'inv_invoice'.tr,
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
