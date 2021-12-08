import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/patient_model.dart';
import 'package:dlabs_apps/app/global_widgets/app_select_input.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrUpdatePatient extends StatelessWidget {
  AddOrUpdatePatient({
    Key? key,
    required this.isUpdateMode,
    this.updateIndex,
    required this.onSearch,
  }) : super(key: key);
  final bool isUpdateMode, onSearch;
  final int? updateIndex;

  final OrganizationBookingController controller =
      Get.put(OrganizationBookingController());

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
            padding: EdgeInsets.all(24),
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
                  () => TextInput(
                    controller: controller.patientIDNumberController,
                    label: "Identity Number*",
                    name: "Identity Number",
                    placeholder: '',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                    type: "number",
                  ),
                ),
                Obx(
                  () => TextInput(
                    controller: controller.patientFullNameController,
                    label: "Full Name*",
                    name: "Full Name",
                    placeholder: 'Romy Roma',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                    type: "text",
                  ),
                ),
                Obx(
                  () => TextInput(
                    controller: controller.patientEmailController,
                    label: "Email*",
                    name: "Email",
                    placeholder: 'e.g. mail@address.com',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                  ),
                ),
                Obx(
                  () => TextInput(
                    controller: controller.patientPhoneController,
                    label: "Phone*",
                    name: "Phone",
                    type: 'number',
                    placeholder: '',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                  ),
                ),
                Obx(
                  () => TextInput(
                    controller: controller.patientDateController,
                    label: 'Date of Birth',
                    type: 'date',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                    name: 'date of birth',
                    placeholder: '16/07/2021',
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Gender'),
                ),
                Row(
                  children: [
                    Obx(
                      () => Radio(
                        value: '0',
                        groupValue: controller.genderValue.value,
                        onChanged: (String? value) {
                          controller.genderValue.value = value ?? '0';
                        },
                      ),
                    ),
                    const Text('Male'),
                    Obx(
                      () => Radio(
                        value: '1',
                        groupValue: controller.genderValue.value,
                        onChanged: (String? value) {
                          controller.genderValue.value = value ?? '1';
                        },
                      ),
                    ),
                    const Text('Female'),
                  ],
                ),
                Obx(
                  () => TextInput(
                    controller: controller.patientAddressController,
                    label: 'Address*',
                    errorMsg: controller.picIdNumberErrorMessage.value,
                    type: 'textarea',
                    name: 'address',
                  ),
                ),
<<<<<<< HEAD
                // SelectInput(
                //   items: controller.testTypeItems,
                //   selectedItem: controller.testTypeSelected.value,
                //   label: 'Test Type*',
                //   errorMsg: "",
                //   name: '',
                // ),
=======
                SelectInput(
                  items: controller.testTypeItems,
                  selectedItem: controller.testTypeSelected.value,
                  label: 'Test Type*',
                  errorMsg: "",
                  name: '',
                ),
>>>>>>> 2f7a030f20d4c89829b57e055fb97175cb4ca13f
                Obx(() {
                  int _indexSelected =
                      int.parse(controller.testTypeSelected.value);
                  return Text(
                    'Price : Rp ${controller.testTypeItems[_indexSelected - 1]['price']},-',
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
                  onPressed: isUpdateMode
                      ? () {
                          controller.updatePatientData(
                            updateIndex ?? 0,
                            onSearch: onSearch,
                            list: onSearch
                                ? controller.searchResult
                                : controller.patientList,
                          );
                          controller.clearTextController();
                          Get.back();
                        }
                      : () {
                          /// TODO it works like charm but still not good enough.
                          /// Unclean
                          /// Still need to ref
                          controller.onAddPatient();
                          controller.updateTotalPrice();
                          controller.clearTextController();
                          Get.back();
                        },
                  child: Text(
                    isUpdateMode ? 'Update' : 'Add',
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
