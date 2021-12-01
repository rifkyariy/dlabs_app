import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/text_input.dart';
import 'package:dlabs_apps/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrUpdatePatient extends StatelessWidget {
  AddOrUpdatePatient({Key? key}) : super(key: key);

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
                  controller: controller.picIdNumberController,
                  label: "Identity Number*",
                  name: "Identity Number",
                  placeholder: '3372050909098998',
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),
              Obx(
                () => TextInput(
                  controller: controller.picIdNumberController,
                  label: "Full Name*",
                  name: "Full Name",
                  placeholder: '3372050909098998',
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),
              Obx(
                () => TextInput(
                  controller: controller.picIdNumberController,
                  label: "Email*",
                  name: "PIC ID Number",
                  placeholder: '3372050909098998',
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),
              Obx(
                () => TextInput(
                  controller: controller.picIdNumberController,
                  label: "PIC ID Number*",
                  name: "PIC ID Number",
                  placeholder: '3372050909098998',
                  errorMsg: controller.picIdNumberErrorMessage.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
