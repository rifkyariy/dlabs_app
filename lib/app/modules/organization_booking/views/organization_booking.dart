import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/app_icons.dart';
import 'package:dlabs_apps/app/global_widgets/app_select_input.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:dlabs_apps/app/modules/organization_booking/local_widgets/booking_list_tile.dart';
import 'package:dlabs_apps/app/modules/organization_booking/views/add_or_update_patient.dart';
import 'package:dlabs_apps/app/modules/organization_booking/views/view_patient_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizationBooking extends GetView<OrganizationBookingController> {
  const OrganizationBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: const Color(0xFF1176BC),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Organization Book Test',
          style: BoldTextStyle(
            const Color(0xFF323F4B),
          ),
        ),
        centerTitle: true,
        actions: const [],
        elevation: 2.0,
        backgroundColor: Colors.white,
        shadowColor: lightGreyColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fill this form to book a test',
                  style: regularTextStyle(greyColor),
                ),
              ),
              const SizedBox(height: 27.0),

              // PIC ID Number
              Obx(
                () => TextInput(
                  controller: controller.picIdNumberController,
                  label: "PIC ID Number*",
                  name: "PIC ID Number",
                  placeholder: '3372050909098998',
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picEmailController,
                  label: "PIC Email*",
                  name: "PIC Email",
                  placeholder: 'e.g. mail@address.com',
                  errorMsg: controller.picIdNumberErrorMessage
                      .value, //TODO tambah error message
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picPhoneController,
                  label: "PIC Phone*",
                  name: "PIC Phone",
                  placeholder: '+628123456789',
                  errorMsg: controller.picIdNumberErrorMessage
                      .value, //TODO tambah error message
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picNameController,
                  label: "PIC Name*",
                  name: "PIC Phone",
                  placeholder: 'Romy Roma',
                  errorMsg: controller.picIdNumberErrorMessage
                      .value, //TODO tambah error message
                ),
              ),

              const SizedBox(height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Test Information',
                    style: regularTextStyle(primaryColor),
                  ),
                ],
              ),
              Divider(color: greyColor),
              const SizedBox(height: 16),

              // // Test Purpses
              // SelectInput(
              //   items: const [
              //     {
              //       'id': '1',
              //       'value': 'Check Up',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //   ],
              //   selectedItem: '1',
              //   label: 'Test Purpose*',
              //   errorMsg: "",
              //   name: '',
              // ),

              // // Test Date
              // TextInput(
              //   controller: controller.testDateController,
              //   label: 'Test Date*',
              //   type: 'date',
              //   errorMsg: "",
              //   name: 'date of birth',
              // ),

              // // Service
              // SelectInput(
              //   items: const [
              //     {
              //       'id': '1',
              //       'value': 'Check Up',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //   ],
              //   selectedItem: '1',
              //   label: 'Service*',
              //   errorMsg: "",
              //   name: '',
              // ),

              // // Service
              // SelectInput(
              //   items: const [
              //     {
              //       'id': '1',
              //       'value': 'Check Up',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //     {
              //       'id': '2',
              //       'value': 'Make Sure',
              //     },
              //   ],
              //   selectedItem: '1',
              //   label: 'Location*',
              //   errorMsg: "",
              //   name: '',
              // ),

              // Map text, this is cool btw
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(AppIcons.waypoint, color: primaryColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          // Long text for testing flexibleity
                          Text(
                            'Jl. Aries Utama IV No.7, RT.12/RW.8, Meruya Utara, Kec. Kembangan, Kota Jakarta Barat.',
                            textAlign: TextAlign.justify,
                            style: regularTextStyle(blackColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 55),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Patient Information',
                      style: regularTextStyle(primaryColor),
                    ),
                    const Spacer(),
                    Text('Total Data : ', style: regularTextStyle(blackColor)),
                    Text(
                      controller.dummyList.length.toString(),
                      style: BoldTextStyle(blackColor),
                    )
                  ],
                ),
              ),
              Divider(color: greyColor),

              const SizedBox(height: 16),

              // Add patient data button

              OutlinedButton(
                onPressed: () => {Get.to(() => AddOrUpdatePatient())},
                child: const Text('Add Patient Data'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 43),
                  primary: primaryColor,
                  side: BorderSide(color: primaryColor),
                ),
              ),

              // Add Patient Data Component
              const SizedBox(height: 14),

              Obx(
                () => Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListView.builder(
                        semanticChildCount: controller.dummyList.length < 5
                            ? controller.dummyList.length
                            : 5,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.dummyList.length < 5
                            ? controller.dummyList.length
                            : 5,
                        itemBuilder: (context, index) {
                          return BookingListTile(
                            key: Key(index.toString()),
                            title: controller.dummyList[index].fullName,
                            subtitle:
                                'ID No : ${controller.dummyList[index].identityNumber}',
                            deleteButtonPressed: (context) {
                              controller.dummyList.removeAt(index);
                              controller.updateTotalPrice();
                            },
                          );
                        },
                      ),

                      // View All Botton

                      controller.dummyList.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF5F5F5),
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.to(
                                    () => ViewPatientList(),
                                  );
                                },
                                child: Text(
                                  'View All',
                                  style: BoldTextStyle(primaryColor),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(height: 0, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: [
                  Text(
                    'Total Price : ',
                    style: mediumTextStyle(blackColor),
                  ),
                  Obx(
                    () => Text(
                      'Rp ${controller.totalBookingPrice.value},-',
                      style: BoldTextStyle(primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: TextButton(
                onPressed: () {},
                child: Text('Submit', style: regularTextStyle(whiteColor)),
                style: TextButton.styleFrom(
                  primary: whiteColor,
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
