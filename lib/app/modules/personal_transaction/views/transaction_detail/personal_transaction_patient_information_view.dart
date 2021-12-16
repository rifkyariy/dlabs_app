import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_box.dart';
import 'package:dlabs_apps/app/global_widgets/app_detail_information_item.dart';
import 'package:dlabs_apps/app/global_widgets/app_single_button_slideable.dart';
import 'package:dlabs_apps/app/global_widgets/app_title_with_button.dart';
import 'package:dlabs_apps/app/modules/personal_transaction/controller/transaction_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalTransactionPatientInformationView
    extends GetView<TransactionViewController> {
  const PersonalTransactionPatientInformationView({Key? key}) : super(key: key);

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
            /// Patient information
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              flex: FlexGroup(3, 2),
              leading: [
                ///
                /// Left Part of the table
                /// Consist of title and Information
                ///
                AppDetailInformationItem(
                  'Full Name',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  'Romy Roma',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  'Full Name',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                  padding: const EdgeInsets.only(top: 20),
                ),
                AppDetailInformationItem(
                  '17/07/1987',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  'Email',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                  padding: const EdgeInsets.only(top: 20),
                ),
                AppDetailInformationItem(
                  'bonny.darma@gmail.com',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
              ],
              trailing: [
                ///
                /// Right Side of the table
                /// Consist of title and information
                ///
                AppDetailInformationItem(
                  'Identity Number',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  '3401918272728',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  'Gender',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                  padding: const EdgeInsets.only(top: 20),
                ),
                AppDetailInformationItem(
                  'Male',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
                AppDetailInformationItem(
                  'Phone',
                  style: BoldTextStyle(blackColor, fontSize: 13),
                  padding: const EdgeInsets.only(top: 20),
                ),
                AppDetailInformationItem(
                  '089789567898',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
              ],
            ),

            /// Adress
            /// Separated because of flex
            AppDetailInformationBox(
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
                  'Perumahan Jeruk, Jl. Merbabu. IV  No.7 Meruya Utara, Kec. Kembangan, Kota Jakarta Barat.',
                  padding: const EdgeInsets.only(top: 5),
                  style: mediumTextStyle(blackColor, fontSize: 13),
                ),
              ],
            ),

            /// Medical Questionaire
            ///

            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              boxMargin: const EdgeInsets.only(top: 20),
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Medical Questionnaire',
                buttonLabel: 'View All',
                titleColor: primaryColor,
              ),
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        /// Questionaire list
                        ListTile(
                          title: Text(
                            'Do you have high blood pressure?',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Yes',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Do you have high blood pressure?',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Yes',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Do you have high blood pressure?',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Yes',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

            /// Medical History
            ///
            AppDetailInformationBox(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              boxMargin: const EdgeInsets.only(top: 20),
              divider: const SizedBox(),
              header: AppTitleWithButton(
                title: 'Medical History',
                buttonLabel: 'View All',
                titleColor: primaryColor,
              ),
              bottom: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        /// Questionaire list

                        AppSingleButtonSlideable(
                          title: Text(
                            'Sample 1 • Swab PCR',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Take care of your health by taking vitamins and drugs that the doctor has given.',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                          trailing: Text(
                            'Positif',
                            style: mediumTextStyle(primaryColor, fontSize: 12),
                          ),
                          buttonLabel: 'Download',
                          isThreeLine: true,
                        ),
                        AppSingleButtonSlideable(
                          title: Text(
                            'Sample 1 • Swab PCR',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Take care of your health by taking vitamins and drugs that the doctor has given.',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                          trailing: Text(
                            'Positif',
                            style: mediumTextStyle(primaryColor, fontSize: 12),
                          ),
                          buttonLabel: 'Download',
                          isThreeLine: true,
                        ),
                        AppSingleButtonSlideable(
                          title: Text(
                            'Sample 1 • Swab PCR',
                            style: BoldTextStyle(blackColor, fontSize: 12),
                          ),
                          subtitle: Text(
                            'Take care of your health by taking vitamins and drugs that the doctor has given.',
                            style: mediumTextStyle(greyColor, fontSize: 12),
                          ),
                          trailing: Text(
                            'Positif',
                            style: mediumTextStyle(primaryColor, fontSize: 12),
                          ),
                          buttonLabel: 'Download',
                          isThreeLine: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
