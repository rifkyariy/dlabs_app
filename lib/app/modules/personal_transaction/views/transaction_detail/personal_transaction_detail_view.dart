import 'package:dlabs_apps/app/modules/personal_transaction/controller/transaction_view_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/global_widgets/app_title_with_button.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_box.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_item.dart';

class PersonalTransactionDetailView extends GetView<TransactionViewController> {
  const PersonalTransactionDetailView({Key? key}) : super(key: key);

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
            _headerComponent(enabled: true),

            /// App Detailed Box
            AppDetailInformationBox(
              title: 'Invoice for',
              header: AppTitleWithButton(
                title: 'Done',
                buttonLabel: 'View Status',
                onTap: () => {},
              ),
              leading: const [
                AppDetailInformationItem('Identity Number'),
                AppDetailInformationItem('Full Name'),
                AppDetailInformationItem('Email'),
                AppDetailInformationItem('Phone'),
              ],

              /// Trailing Button
              trailing: [
                AppDetailInformationItem(
                  '34918172628763',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'Muhammad Akbar ',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'bonny.darma@address.com',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  '+(62) 897856823423',
                  color: blackColor,
                ),
              ],
            ),

            const SizedBox(height: 15),

            AppDetailInformationBox(
              title: 'Test Information',
              leading: const [
                AppDetailInformationItem('Test Purpose'),
                AppDetailInformationItem('Test Date'),
                AppDetailInformationItem('Service'),
                AppDetailInformationItem('Location'),
              ],
              trailing: [
                AppDetailInformationItem(
                  'Check Up',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  '16/07/2021 11:30 AM',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'Drive Thru',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'Jl. Aries Utama IV No.7, RT.12/RW.8, Meruya Utara, Kec. Kembangan, Kota Jakarta Barat.',
                  color: blackColor,
                ),
              ],
            ),

            const SizedBox(height: 15),

            AppDetailInformationBox(
              title: 'Test Information',
              header: AppTitleWithButton(
                title: 'Done',
                buttonLabel: 'View Detail',
                onTap: () {},
              ),

              /// Leading
              leading: [
                AppDetailInformationItem(
                  'Romy Roma',
                  style: BoldTextStyle(blackColor, fontSize: 12),
                ),
                AppDetailInformationItem(
                  '+(62) 8978567898',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'Jl. Godean KM 5. Perum Jeruk II D 18, Gamping, Sleman, Yogyakarta 55529',
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
                  title: 'Swab Antigen',
                  buttonLabel: 'Rp 800.000,-',
                  titleColor: primaryColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                  child: AppDetailInformationItem(
                    '21 Oktober 2021',
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
                  buttonLabel: 'Rp 800.000,-',
                  titleColor: blackColor,
                  buttonLabelColor: blackColor,
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
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
                  'Rp 800.000,-',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  'BCA',
                  color: blackColor,
                ),
                AppDetailInformationItem(
                  '12/10/2021 14.00',
                  color: blackColor,
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),

      /// Bottom Button
      bottomNavigationBar: _bottomButtonComponent(offline: false),
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
                      'DL210717.15',
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
