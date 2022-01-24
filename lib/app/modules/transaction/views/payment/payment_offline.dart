import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/services/currency_formatting.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_android_button.dart';
import 'package:kayabe_lims/app/modules/transaction/local_widgets/transaction_ios_button.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class PaymentOfflineView extends GetView<TransactionViewController> {
  const PaymentOfflineView({Key? key}) : super(key: key);

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
          'Payment',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment deadline',
                          style: mediumTextStyle(greyColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.transactionDetail.cancelDate!,
                          style: BoldTextStyle(blackColor, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 15, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: BoldTextStyle(blackColor, fontSize: 12),
                  ),
                  Text(
                    CurrencyFormat.convertToIdr(
                      (controller.transactionDetail.price ?? 0),
                      2,
                    ),
                    style: BoldTextStyle(dangerColor, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Payment Method / Choose Bank
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 15, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: BoldTextStyle(blackColor, fontSize: 12),
                  ),
                  SelectInput(
                    items: controller.paymentMethodList!.value,
                    selectedItem: controller.selectedPaymentMethod,
                    label: '',
                    errorMsg: "",
                    name: '',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please transfer the total amount to the following bank account:',
                    style: mediumTextStyle(blackColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => Text(
                      'Bank Name: ${controller.selectedPaymentMethodName}',
                      style: mediumTextStyle(blackColor, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => Text(
                      'Account Holder Name: ${controller.selectedAccountHolder}',
                      style: mediumTextStyle(blackColor, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => Text(
                      'Account Number: ${controller.selectedAccountNumber}',
                      style: mediumTextStyle(blackColor, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '*Make sure you have transferred the money before executing the button',
                    style: smallTextStyle(greyColor, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Invoice ID
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 15, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please write:',
                    style: BoldTextStyle(blackColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'INVOICE - ${controller.transactionDetail.transactionId ?? ''}',
                    style: BoldTextStyle(primaryColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'in the transfer news column or if via ATM please transfer the amount of ${CurrencyFormat.convertToIdr(
                      (controller.transactionDetail.price ?? 0),
                      2,
                    )}',
                    style: mediumTextStyle(blackColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
// Invoice ID
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 15, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: greyColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proof of payment',
                    style: BoldTextStyle(blackColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Please upload your proof of transfer below',
                    style: mediumTextStyle(blackColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TransactionTextButton(
                    title: "Choose File",
                    isWhiteBackground: true,
                    onPressed: () async {
                      await controller.getLocalFile();
                    }, // TODO
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Obx(
                    () => Text(
                      controller.uploadedFilename!.value,
                      style: regularTextStyle(greyColor),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
              children: [
                Flexible(
                  flex: 4,
                  child: TransactionTextButton(
                    title: "Upload",
                    isWhiteBackground: false,
                    onPressed: () async {
                      await controller.onUploadPaymentProofPressed(
                        path: controller.paymentProofLocation,
                        transactionId:
                            controller.transactionDetail.transactionId ?? '',
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

  Widget _androidDialog() {
    return SimpleDialog(
      title: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Option",
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              "Please select a payment method",
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
      children: [
        TransactionTextButton(
          title: 'Online',
          isWhiteBackground: false,
          onPressed: () {},
        ),
        const SizedBox(height: 15),
        TransactionTextButton(
          title: 'Offline',
          isWhiteBackground: true,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _iosDialog() {
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
              "Payment Option",
              style: BoldTextStyle(blackColor, fontSize: 19),
            ),
            const SizedBox(height: 18),
            Text(
              "Please select a payment method",
              style: regularTextStyle(
                blackColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      children: [
        const Divider(height: 0, thickness: 1),
        TransactionIosButton(
          title: 'Online',
          onPressed: () {},
        ),
        const Divider(height: 0, thickness: 1),
        TransactionIosButton(
          title: 'Offline',
          onPressed: () {},
        )
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
                    onPressed: enabled ?? false ? () {} : null,
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
