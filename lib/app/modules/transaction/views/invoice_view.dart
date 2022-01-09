import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
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
          'Medical History',
          style: BoldTextStyle(const Color(0xFF323F4B)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Transaction No",
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
                leading: Text(controller.invoiceData.isPrivate ?? '',
                    style: BoldTextStyle(whiteColor, fontSize: 13)),
                trailing: Text(
                    DateFormat.yMMMMd('en_US').format(
                      DateTime.parse(
                          controller.transactionDetail.transactionDate ?? ''),
                    ),
                    style: BoldTextStyle(whiteColor, fontSize: 13)),
              ),
              leading: [
                AppDetailInformationItem(
                  "Full Name",
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
                  "Email",
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
                  "Identity Number",
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
                  "Phone",
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
            ListTile(
              title: Text(
                "Hi, ${controller.invoiceData.name ?? ''}",
                style: BoldTextStyle(blackColor, fontSize: 16),
              ),
              subtitle: Text(
                "The result of test is already released.",
                style: mediumTextStyle(blackColor, fontSize: 12),
              ),
              trailing: TextButton(
                /// If online then close if offline then fuck
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Result',
                      style: regularTextStyle(whiteColor),
                    ),
                    const SizedBox(width: 15),
                    Icon(AppIcons.download, color: whiteColor, size: 15)
                  ],
                ),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(30, 40),
                  maximumSize: const Size(100, 40),
                  side: BorderSide(color: primaryColor),
                ),
              ),
            ),
            AppDetailInformationBox(
              header: AppTitleWithButton(
                title: "Test Information",
                buttonLabel: '',
                titleColor: primaryColor,
              ),
              leading: [
                AppDetailInformationItem(
                  "Test Date",
                  bold: true,
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  controller.invoiceData.testDate ?? '',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  "Location",
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
                  "Identity Number",
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
                    'Total Price',
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
