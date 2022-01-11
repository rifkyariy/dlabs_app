import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/core/utils/size_scalling.dart';
import 'package:kayabe_lims/app/global_widgets/app_select_input_searchable.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/global_widgets/text_input.dart';
import 'package:kayabe_lims/app/modules/update_personal_info/controller/update_personal_info_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UpdatePersonalInfoScreen extends GetView<UpdatePersonalInfoController> {
  const UpdatePersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeScalling.init(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
              ),
              color: primaryColor,
              onPressed: () => Navigator.pop(context)),
          title: Text('', style: BoldTextStyle(blackColor)),
          centerTitle: true,
          actions: [],
          elevation: 0.0,
          backgroundColor: whiteColor,
          shadowColor: lightGreyColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeScalling().setHeight(20),
            left: SizeScalling().setWidth(24),
            right: SizeScalling().setWidth(24),
          ),
          child: Column(
            children: [
              // Logo and Header
              Obx(
                () => Center(
                    child: controller.companyLogo.value.isNotEmpty
                        ? Image.network(
                            controller.companyLogo.value,
                            width: SizeScalling().setWidth(100),
                            height: SizeScalling().setHeight(60),
                          )
                        : null),
              ),

              SizedBox(height: SizeScalling().setHeight(25)),

              // Google Login
              Center(
                child: ElevatedButton.icon(
                  icon: Image.asset(
                    'assets/image/logo-google-48dp.png',
                    width: 20.5,
                    height: 20.5,
                  ),
                  label: Text(
                    'Sign Up with Google',
                    style: subtitleTextStyle(blackColor),
                  ),
                  onPressed: () =>
                      controller.signInController.handleGoogleSignIn(),
                  style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 46),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: lightGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(4.8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                  Text(
                    'or',
                    style: smallTextStyle(blackColor),
                  ),
                  Image.asset(
                    'assets/image/line-divider.png',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Step Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Detail',
                    style: regularTextStyle(primaryColor),
                  ),
                  Text(
                    'Step 2 of 2',
                    style: smallTextStyle(greyColor),
                  )
                ],
              ),
              Divider(color: greyColor),

              const SizedBox(height: 16),

              // Nationality
              Obx(
                () => SearchableSelectInput(
                  selectedItem: controller.selectedNationalityString.value,
                  items: controller.nationalityList!.value,
                  label: 'Nationality',
                  errorMsg: "",
                  name: '',
                  isDisabled: false,
                ),
              ),

              // Identity Number
              Obx(
                () => TextInput(
                  controller: controller.idNumberController,
                  label: 'Identity Number / Passport',
                  type: 'text',
                  errorMsg: controller.identityNumberErrorMessage.value,
                  name: 'identity number',
                ),
              ),

              // Phone Number
              TextInput(
                controller: controller.phoneNumberController,
                label: 'Phone Number',
                type: 'phone',
                errorMsg: controller.phoneNumberErrorMessage.value,
                name: 'phone number',
              ),

              // Date of Birth
              TextInput(
                controller: controller.dateOfBirthController,
                label: 'Date of Birth',
                type: 'date',
                errorMsg: controller.dateOfBirthErrorMessage.value,
                name: 'date of birth',
                lastDate: DateTime.now(),
              ),

              // Gender
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Gender'),
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
                  const Text('Male'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.genderValue.value,
                      onChanged: (String? value) {
                        controller.genderValue.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('Female'),
                ],
              ),

              // Address
              TextInput(
                controller: controller.addressController,
                label: 'Address',
                errorMsg: controller.addressErrorMessage.value,
                placeholder: '',
                type: 'textarea',
                name: 'address',
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
        child: Obx(
          () => AppButton(
            text: 'Sign Up',
            textColor: whiteColor,
            onClicked: () => controller.signUpHandler(),
            isLoading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
