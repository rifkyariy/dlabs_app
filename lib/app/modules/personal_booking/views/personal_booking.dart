import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/core/utils/size_scalling.dart';
import 'package:dlabs_apps/app/global_widgets/app_select_input.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/personal_booking/controller/personal_booking_controller.dart';
// import 'package:select_form_field/select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalBooking extends GetView<PersonalBookingController> {
  PersonalBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
              ),
              color: Color(0xff000000),
              onPressed: () => Navigator.pop(context)),
          title: Text('Personal Book Test', style: BoldTextStyle(blackColor)),
          centerTitle: true,
          actions: [],
          elevation: 2.0,
          backgroundColor: whiteColor,
          shadowColor: lightGreyColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fill this form to book a test',
                  style: regularTextStyle(greyColor),
                ),
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Test Date
              Obx(() => SelectInput(
                    items: controller.serviceList!.value,
                    selectedItem: controller.selectedService,
                    label: 'Service',
                    errorMsg: "",
                    name: '',
                  )),

              // Patient Subject
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Patient Subject'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: 'myself',
                      groupValue: controller.patientSubject.value,
                      onChanged: (String? value) {
                        controller.patientSubject.value = value ?? 'myself';
                        controller.toggleFillPatient();
                      },
                    ),
                  ),
                  const Text('My Self'),
                  Obx(
                    () => Radio(
                      value: 'other',
                      groupValue: controller.patientSubject.value,
                      onChanged: (String? value) {
                        controller.patientSubject.value = value ?? 'other';
                        controller.toggleFillPatient();
                      },
                    ),
                  ),
                  const Text('Other'),
                ],
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Divider Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Patient Information',
                    style: regularTextStyle(primaryColor),
                  ),
                ],
              ),
              Divider(color: greyColor),
              const SizedBox(height: 16),

              // Identity Number
              Obx(
                () => TextInput(
                  controller: controller.idNumberController,
                  label: 'Identity Number',
                  type: 'number',
                  errorMsg: controller.identityNumberErrorMessage.value,
                  name: 'identity number',
                  placeholder: '3372050909098998',
                  isDisabled: controller.patientSubject.value == 'myself',
                ),
              ),

              // Full Name
              Obx(
                () => TextInput(
                  controller: controller.fullNameController,
                  label: "Full Name",
                  name: "fullname",
                  placeholder: 'Romy Roma',
                  errorMsg: controller.fullNameErrorMessage.value,
                  isDisabled: controller.patientSubject.value == 'myself',
                ),
              ),

              // Email Address
              Obx(
                () => TextInput(
                  controller: controller.emailController,
                  label: "Email Address",
                  name: "email",
                  placeholder: 'e.g. mail@address.com',
                  errorMsg: controller.emailErrorMessage.value,
                ),
              ),

              // Phone Number
              Obx(
                () => TextInput(
                  controller: controller.phoneNumberController,
                  label: 'Phone Number',
                  type: 'phone',
                  placeholder: '+628625378973',
                  errorMsg: controller.phoneNumberErrorMessage.value,
                  name: 'phone number',
                ),
              ),

              // Date of Birth
              Obx(
                () => TextInput(
                  controller: controller.dateOfBirthController,
                  label: 'Date of Birth',
                  type: 'date',
                  lastDate: DateTime.now(),
                  errorMsg: controller.dateOfBirthErrorMessage.value,
                  name: 'date of birth',
                  isDisabled: controller.patientSubject.value == 'myself'
                      ? true
                      : false,
                ),
              ),

              // Gender
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gender',
                  style: mediumTextStyle(blackColor, fontSize: 14),
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.genderValue.value,
                      onChanged: controller.patientSubject.value == 'myself'
                          ? null
                          : (String? value) {
                              controller.genderValue.value = value ?? '1';
                            },
                    ),
                  ),
                  Text(
                    'Male',
                    style: mediumTextStyle(blackColor, fontSize: 14),
                  ),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.genderValue.value,
                      onChanged: controller.patientSubject.value == 'myself'
                          ? null
                          : (String? value) {
                              controller.genderValue.value = value ?? '0';
                            },
                    ),
                  ),
                  Text(
                    'Female',
                    style: mediumTextStyle(blackColor, fontSize: 14),
                  ),
                ],
              ),

              // Address
              Obx(
                () => TextInput(
                  controller: controller.addressController,
                  label: 'Address',
                  errorMsg: controller.addressErrorMessage.value,
                  type: 'textarea',
                  name: 'address',
                  isDisabled: controller.patientSubject.value == 'myself',
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
                type: 'date',
                errorMsg: "",
                firstDate: DateTime.now(),
                name: 'test date',
              ),

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

              SizedBox(
                height: SizeScalling().setHeight(15),
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

              // Test Type
              Obx(() => SelectInput(
                    items: controller.testTypeList!.value,
                    selectedItem: controller.selectedTestType,
                    label: 'Test Type',
                    errorMsg: "",
                    name: '',
                  )),

              Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => Text(
                      'Price : ${controller.servicePriceString.value}',
                      style: regularTextStyle(primaryColor),
                    )),
              ),

              const SizedBox(height: 29),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
              top: 12, bottom: 24.0, left: 24.0, right: 24.0),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: lightGreyColor, width: 1),
            ),
          ),
          // Submit Button
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => Text(
                      'Total Price : ${controller.servicePriceString.value}',
                      style: regularTextStyle(blackColor),
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Button(
                  text: 'Next',
                  textColor: whiteColor,
                  onClicked: () => controller.personalBookHandler(),
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          )),
    );
  }
}
