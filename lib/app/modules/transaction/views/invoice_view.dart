import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_box.dart';
import 'package:kayabe_lims/app/global_widgets/app_detail_information_item.dart';
import 'package:kayabe_lims/app/global_widgets/app_title_with_button.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InvoiceView extends GetView<TransactionViewController> {
  const InvoiceView({Key? key}) : super(key: key);

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
          'inv_invoice'.tr,
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "inv_transaction_number".tr,
                style: mediumTextStyle(blackColor, fontSize: 13),
              ),
              subtitle: Text(
                controller.invoiceData.transactionId ?? '',
                style: BoldTextStyle(primaryColor, fontSize: 16),
              ),
              trailing: Image.network(controller.invoiceData.logoUrl ?? ''),
            ),
            AppDetailInformationBox(
              backgroundColor: primaryColor,
              dividerColor: whiteColor,
              dividerThickness: 1,
              flex: FlexGroup(2, 1),
              header: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 24, right: 30),
                leading: Text(
                  controller.invoiceData.isPrivate ?? '',
                  style: BoldTextStyle(whiteColor, fontSize: 13),
                ),
                trailing: Text(
                    DateFormat.yMMMMd('en_US').format(
                      DateTime.parse(
                          controller.transactionDetail.transactionDate ?? ''),
                    ),
                    style: BoldTextStyle(whiteColor, fontSize: 13)),
              ),
              leading: [
                AppDetailInformationItem(
                  "gen_fullname".tr,
                  bold: true,
                  color: whiteColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.name ?? '',
                  bold: false,
                  color: whiteColor,
                ),
                const AppDetailInformationItem(''),
                AppDetailInformationItem(
                  "gen_email".tr,
                  bold: true,
                  color: whiteColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.email ?? '',
                  bold: false,
                  color: whiteColor,
                ),
              ],
              trailing: [
                AppDetailInformationItem(
                  'gen_identity_number_short'.tr,
                  bold: true,
                  color: whiteColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.identityNumber ?? '',
                  bold: false,
                  color: whiteColor,
                ),
                const AppDetailInformationItem(''),
                AppDetailInformationItem(
                  "gen_phone".tr,
                  bold: true,
                  color: whiteColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.phone ?? '',
                  bold: false,
                  color: whiteColor,
                ),
              ],
              bottom: const [SizedBox(height: 10)],
            ),
            AppDetailInformationBox(
              header: AppTitleWithButton(
                title: 'gen_test_information'.tr,
                buttonLabel: '',
                titleColor: primaryColor,
              ),
              leading: [
                AppDetailInformationItem(
                  "gen_test_date".tr,
                  bold: true,
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.testDate ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  "gen_location".tr,
                  bold: true,
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.locationName ?? '',
                  color: blackColor,
                ),
              ],
              trailing: [
                AppDetailInformationItem(
                  'gen_identity_number'.tr,
                  bold: true,
                  color: whiteColor,
                ),
              ],
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppDetailInformationItem(
                    controller.invoiceData.locationAddress ?? '',
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 100,
              color: whiteColor,
              child: Center(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    'gen_total_price'.tr,
                    style: mediumTextStyle(blackColor, fontSize: 12),
                  ),
                  subtitle: Text(
                    'IDR ${controller.invoiceData.price ?? ''}',
                    style: mediumTextStyle(dangerColor, fontSize: 12),
                  ),
                  trailing: Image.network(controller.invoiceData.imgUrl ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
