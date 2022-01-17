import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/patient_model.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input_searchable.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrUpdatePatient extends StatefulWidget {
  AddOrUpdatePatient({
    Key? key,
    required this.isUpdateMode,
    this.updateIndex,
    required this.onSearch,
  }) : super(key: key);
  final bool isUpdateMode, onSearch;
  final int? updateIndex;

  @override
  State<AddOrUpdatePatient> createState() => _AddOrUpdatePatientState();
}

class _AddOrUpdatePatientState extends State<AddOrUpdatePatient> {
  final OrganizationBookingController controller =
      Get.put(OrganizationBookingController());

  @override
  void initState() {
    controller.addPriceListener();

    super.initState();
  }

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
            'Add Patient',
            style: BoldTextStyle(
              const Color(0xFF323F4B),
            ),
          ),
          centerTitle: true,
          elevation: 2.0,
          backgroundColor: Colors.white,
          shadowColor: lightGreyColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 20),
                Obx(
                  () => Column(
                    children: [
                      SearchableSelectInput(
                        selectedItem: controller.patientSelectedNationality,
                        items: controller.nationalityList!.value,
                        label: 'Nationality',
                        errorMsg: "",
                        name: '',
                        isDisabled: false,
                      ),

                      // id Number
                      TextInput(
                        controller: controller.patientIDNumberController,
                        label: "Identity Number",
                        name: "Identity Number",
                        errorMsg: controller.identityNumberErrorMessage.value,
                        type: "number",
                      ),

                      // Fullname
                      TextInput(
                        controller: controller.patientFullNameController,
                        label: "Full Name",
                        name: "Full Name",
                        errorMsg: controller.fullNameErrorMessage.value,
                        type: "text",
                      ),

                      // email addresss
                      TextInput(
                        controller: controller.patientEmailController,
                        label: "Email",
                        name: "Email",
                        placeholder: 'Type email',
                        errorMsg: controller.emailErrorMessage.value,
                      ),

                      // Phone
                      TextInput(
                        controller: controller.patientPhoneController,
                        label: "Phone",
                        name: "Phone",
                        type: 'phone',
                        errorMsg: controller.phoneNumberErrorMessage.value,
                      ),

                      // Date of birth
                      TextInput(
                        controller: controller.patientDateController,
                        label: 'Date of Birth',
                        type: 'date',
                        errorMsg: controller.dateOfBirthErrorMessage.value,
                        name: 'date of birth',
                        lastDate: DateTime.now(),
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
                              onChanged: (String? value) {
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
                              onChanged: (String? value) {
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
                      TextInput(
                        controller: controller.patientAddressController,
                        label: 'Address',
                        errorMsg: controller.addressErrorMessage.value,
                        type: 'textarea',
                        name: 'address',
                      ),
                    ],
                  ),
                ),
                // Nationality

                // Test Type
                Obx(
                  () => SelectInput(
                    items: controller.testTypeList!.value,
                    selectedItem: controller.selectedTestType,
                    label: 'Test Type',
                    errorMsg: "",
                    name: '',
                  ),
                ),
                Obx(() {
                  return Text(
                    'Price : ${controller.servicePriceString}',
                    style: regularTextStyle(primaryColor),
                  );
                })
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(height: 0, thickness: 1),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: TextButton(
                  onPressed: widget.isUpdateMode
                      ? () {
                          controller.updatePatientData(
                            widget.updateIndex ?? 0,
                            onSearch: widget.onSearch,
                            list: widget.onSearch
                                ? controller.searchResult
                                : controller.patientList,
                          );
                          controller.updateTotalPrice();
                          controller.clearTextController();
                          Get.back();
                        }
                      : () {
                          /// TODO it works like charm but still not good enough.
                          /// Unclean
                          /// Still need to ref
                          if (controller.onAddPatient()) {
                            controller.updateTotalPrice();
                            controller.clearTextController();
                            Get.back();
                          }
                        },
                  child: Text(
                    widget.isUpdateMode ? 'Update' : 'Add',
                    style: regularTextStyle(whiteColor),
                  ),
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
        ));
  }
}
