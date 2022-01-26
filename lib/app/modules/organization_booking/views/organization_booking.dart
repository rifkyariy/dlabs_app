import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/app_icons.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/data/services/currency_formatting.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:kayabe_lims/app/modules/organization_booking/local_widgets/booking_list_tile.dart';
import 'package:kayabe_lims/app/modules/organization_booking/views/add_or_update_patient.dart';
import 'package:kayabe_lims/app/modules/organization_booking/views/view_patient_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganizationBooking extends GetView<OrganizationBookingController> {
  const OrganizationBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

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
                  label: "PIC ID Number",
                  name: "PIC ID Number",
                  placeholder: '3372050909098998',
                  type: 'number',
                  isDisabled: true,
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picEmailController,
                  label: "PIC Email",
                  name: "PIC Email",
                  placeholder: 'e.g. mail@address.com',
                  isDisabled: true,
                  errorMsg: controller
                      .picEmailErrorMessage.value, //TODO tambah error message
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picPhoneController,
                  label: "PIC Phone",
                  name: "PIC Phone",
                  placeholder: '+628123456789',
                  type: 'phone',
                  isDisabled: true,
                  errorMsg: controller
                      .picPhoneErrorMessage.value, //TODO tambah error message
                ),
              ),

              Obx(
                () => TextInput(
                  controller: controller.picNameController,
                  label: "PIC Name",
                  name: "PIC Name",
                  placeholder: 'Romy Roma',
                  isDisabled: true,
                  errorMsg: controller
                      .picNameErrorMessage.value, //TODO tambah error message
                ),
              ),

              // Divider Header
              const SizedBox(height: 16),
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

              // Test Purpose
              Obx(
                () => SelectInput(
                  items: controller.testPurposeList!.value,
                  selectedItem: controller.selectedTestPurpose,
                  label: 'Test Purpose',
                  errorMsg: "",
                  name: '',
                ),
              ),

              // Test Date
              TextInput(
                controller: controller.testDateController,
                label: 'Test Date',
                type: 'datetime',
                errorMsg: "",
                firstDate: DateTime.now(),
                name: 'test date',
              ),

              // Test Date
              Obx(() => SelectInput(
                    items: controller.serviceList!.value,
                    selectedItem: controller.selectedService,
                    label: 'Service',
                    errorMsg: "",
                    name: '',
                  )),

              // Test Location
              Obx(() => SelectInput(
                    items: controller.locationList!.value,
                    selectedItem: controller.selectedLocation,
                    label: 'Location',
                    errorMsg: "",
                    name: '',
                    isDisabled: controller.selectedServiceString.value != '1'
                        ? true
                        : false,
                  )),

              Obx(
                () => Visibility(
                  visible: controller.selectedServiceString.value == '1',
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Image.asset('assets/image/pin-icon.png',
                            width: SizeScalling().setWidth(15)),
                        SizedBox(
                          width: SizeScalling().setWidth(10),
                        ),
                        Flexible(
                          child: Text(
                            controller.locationAddress.value,
                            style: smallTextStyle(blackColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Address
              Obx(
                () => Visibility(
                  visible: controller.selectedServiceString.value != '1'
                      ? true
                      : false,
                  child: TextInput(
                    controller: controller.testLocationController,
                    label: 'Location Address',
                    errorMsg: controller.testLocationErrorMessage.value,
                    type: 'textarea',
                    name: 'address',
                  ),
                ),
              ),

              const SizedBox(height: 16),

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
                      controller.patientList.length.toString(),
                      style: BoldTextStyle(blackColor),
                    )
                  ],
                ),
              ),
              Divider(color: greyColor),

              const SizedBox(height: 16),

              // Add patient data button

              OutlinedButton(
                onPressed: () {
                  controller.isUpdateMode.value = false;
                  controller.clearTextController();
                  Get.to(() => AddOrUpdatePatient(
                        isUpdateMode: false,
                        onSearch: false,
                      ));
                },
                child: Text(
                  'Add Patient Data',
                  style: BoldTextStyle(primaryColor),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 43),
                  primary: primaryColor,
                  side: BorderSide(color: primaryColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.patientListErrorMessage.value,
                    style: smallTextStyle(dangerColor),
                  ),
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
                        semanticChildCount: controller.patientList.length < 5
                            ? controller.patientList.length
                            : 5,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.patientList.length < 5
                            ? controller.patientList.length
                            : 5,
                        itemBuilder: (context, index) {
                          return BookingListTile(
                              key: Key(index.toString()),
                              title: controller.patientList[index].fullName,
                              subtitle:
                                  'ID No : ${controller.patientList[index].identityNumber} \nTest Type : ${controller.patientList[index].testType}  ',
                              deleteButtonPressed: (context) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Delete Patient'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Are you sure want to delete this patient?',
                                            style: regularTextStyle(blackColor),
                                          ),
                                          Text('This process cannot be undone',
                                              style:
                                                  regularTextStyle(blackColor))
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: whiteColor,
                                                  elevation: 0,
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: greyColor)),
                                              child: Text('Cancel',
                                                  style: mediumTextStyle(
                                                      greyColor)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: primaryColor,
                                                elevation: 0,
                                              ),
                                              child: Text('Confirm',
                                                  style: mediumTextStyle(
                                                      whiteColor)),
                                              onPressed: () {
                                                // Delete Button Pressed
                                                // Remove dummyList at x index
                                                controller.deletePatient(index);

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              updateButtonPressed: (context) {
                                controller.isUpdateMode.value = true;
                                controller
                                    .updateTextControllerBasedOnIndex(index);
                                Get.to(
                                  () => AddOrUpdatePatient(
                                    onSearch: false,
                                    isUpdateMode: true,
                                    updateIndex: index,
                                  ),
                                );
                              });
                        },
                      ),

                      // View All Button
                      controller.patientList.isEmpty
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
                      CurrencyFormat.convertToIdr(
                          controller.totalBookingPrice.value, 2),
                      style: BoldTextStyle(primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Obx(
                () => AppButton(
                  text: 'Submit',
                  isLoading: controller.isLoading.value,
                  textColor: whiteColor,
                  onClicked: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirmation'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text(
                                'Are you sure and agree that the information you have filled on the form is original and correct data ?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: whiteColor,
                                    elevation: 0,
                                    side:
                                        BorderSide(width: 1, color: greyColor)),
                                child: Text('Cancel',
                                    style: mediumTextStyle(greyColor)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  elevation: 0,
                                ),
                                child: Text('Confirm',
                                    style: mediumTextStyle(whiteColor)),
                                onPressed: () {
                                  controller.organizationBookHandler();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
