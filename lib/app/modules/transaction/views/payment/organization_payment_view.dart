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
              header: AppTitleWithButton(
                title: AppConverter.transactionEnumToString(
                    controller.currentTransactionStatus),
                buttonLabel: 'tr_d_view_status'.tr,
                onTap: () {
                  controller.toTrackingProcessView();
                }, // Create onTap Handler
                titleColor: controller.currentTransactionStatus ==
                        TRANSACTIONSTATUS.canceled
                    ? dangerColor
                    : blackColor,
              ),
              title: 'tr_d_invoice_for'.tr,
              leading: [
                _thinDetailInformationItem('tr_d_transaction_date'.tr),
                _thinDetailInformationItem('gen_identity_number_short'.tr),
                _thinDetailInformationItem('gen_fullname'.tr),
                _thinDetailInformationItem('gen_email'.tr),
                _thinDetailInformationItem('gen_phone'.tr),
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
                title: 'gen_test_information'.tr,
                buttonLabel: '',
                onTap: () {},
              ),

              /// Leading
              leading: [
                _thinDetailInformationItem('gen_test_purpose'.tr),
                _thinDetailInformationItem('gen_test_date'.tr),
                _thinDetailInformationItem('p_bt_service'.tr),
                _thinDetailInformationItem('gen_location'.tr),
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
                title: 'gen_patient_information'.tr,
                buttonLabel: 'gen_view_all'.tr,
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
                          '${"o_bt_id_number".tr} : ${(controller.transactionDetail.patientList ?? [])[index].identityNumber ?? ''} \n${"gen_test_type".tr} : ${(controller.transactionDetail.patientList ?? [])[index].testTypeText ?? ''} \n${"gen_phone".tr} : ${(controller.transactionDetail.patientList ?? [])[index].phone ?? ''}',
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
                  //   'BCA',
                  //   color: blackColor,
                  // ),

                  AppDetailInformationItem(controller.paidDate.value),
                ],
                bottom: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child:
                        AppDetailInformationItem('tr_d_payment_make_sure'.tr),
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
                    }, // TODO Cacel ASW
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
                      'tr_d_org_service'.tr,
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
      buttonLabel: 'tr_d_view_detail'.tr,
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
}
