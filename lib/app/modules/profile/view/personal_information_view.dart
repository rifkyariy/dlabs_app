import 'package:get/get.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input_searchable.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/profile/controller/profile_view_controller.dart';

class PersonalInformation extends GetView<ProfileViewController> {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        actions: const [],
        elevation: 1.0,
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          color: blackColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Personal Information', style: BoldTextStyle(blackColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              // My Data
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
                  child: controller.isLoaded.value
                      ? Column(
                          children: [
                            // Nationality
                            SearchableSelectInput(
                              selectedItem: controller.selectedNationality,
                              items: controller.nationalityList!.value,
                              label: 'Nationality',
                              errorMsg: "",
                              name: '',
                            ),

                            // Identity Number
                            TextInput(
                              controller: controller.idNumberController,
                              label: 'Identity Number',
                              type: 'text',
                              errorMsg:
                                  controller.identityNumberErrorMessage.value,
                              name: 'identity number',
                            ),

                            // Full Name
                            TextInput(
                              controller: controller.fullNameController,
                              label: "Fullname",
                              name: "fullname",
                              errorMsg: controller.fullNameErrorMessage.value,
                            ),

                            // Email Address
                            TextInput(
                              controller: controller.emailController,
                              label: "Email Address",
                              name: "email",
                              errorMsg: controller.emailErrorMessage.value,
                              isDisabled: true,
                            ),

                            // Phone Number
                            TextInput(
                              controller: controller.phoneNumberController,
                              label: 'Phone Number',
                              type: 'phone',
                              errorMsg:
                                  controller.phoneNumberErrorMessage.value,
                              name: 'phone number',
                            ),

                            // Date of Birth
                            TextInput(
                              controller: controller.dateOfBirthController,
                              label: 'Date of Birth',
                              type: 'date',
                              lastDate: DateTime.now(),
                              errorMsg:
                                  controller.dateOfBirthErrorMessage.value,
                              name: 'date of birth',
                            ),

                            // Gender
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Gender',
                                style:
                                    mediumTextStyle(blackColor, fontSize: 14),
                              ),
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => Radio(
                                    value: '1',
                                    groupValue: controller.genderValue.value,
                                    onChanged: (String? value) {
                                      controller.genderValue.value =
                                          value ?? '1';
                                    },
                                  ),
                                ),
                                Text(
                                  'Male',
                                  style:
                                      mediumTextStyle(blackColor, fontSize: 14),
                                ),
                                Obx(
                                  () => Radio(
                                    value: '0',
                                    groupValue: controller.genderValue.value,
                                    onChanged: (String? value) {
                                      controller.genderValue.value =
                                          value ?? '0';
                                    },
                                  ),
                                ),
                                Text(
                                  'Female',
                                  style:
                                      mediumTextStyle(blackColor, fontSize: 14),
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
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 10),
                            Text(
                              'Loading Patient Information',
                              style: smallTextStyle(primaryColor),
                            )
                          ],
                        ),
                ),
              ),
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
            Obx(
              () => AppButton(
                text: 'Submit',
                textColor: whiteColor,
                onClicked: () {
                  controller.handleUpdateProfile();
                },
                isLoading: controller.isLoading.value,
              ),
            )
          ],
        ),
      ),
    );
  }
}
