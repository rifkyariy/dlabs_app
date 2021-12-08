import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:dlabs_apps/app/modules/personal_booking/controller/personal_booking_controller.dart';
// import 'package:select_form_field/select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Questionnaire extends GetView<PersonalBookingController> {
  const Questionnaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
              ),
              color: blackColor,
              onPressed: () => Navigator.pop(context)),
          title: Text('Questionnaire', style: BoldTextStyle(blackColor)),
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
                  'Fill this questionnaire to book a test for medical history',
                  style: regularTextStyle(greyColor),
                ),
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Blood Pressure
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Do you have high blood pressure?'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.question1.value,
                      onChanged: (String? value) {
                        controller.question1.value = value ?? '1';
                      },
                    ),
                  ),
                  const Text('Yes'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.question1.value,
                      onChanged: (String? value) {
                        controller.patientSubject.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Blood Pressure
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Do you have asthma?'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.question2.value,
                      onChanged: (String? value) {
                        controller.question2.value = value ?? '1';
                      },
                    ),
                  ),
                  const Text('Yes'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.question2.value,
                      onChanged: (String? value) {
                        controller.question2.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Blood Pressure
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Do you have diabetes?'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.question3.value,
                      onChanged: (String? value) {
                        controller.question3.value = value ?? '1';
                      },
                    ),
                  ),
                  const Text('Yes'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.question3.value,
                      onChanged: (String? value) {
                        controller.question3.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Blood Pressure
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Do you have low blood pressure?'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.question4.value,
                      onChanged: (String? value) {
                        controller.question4.value = value ?? '1';
                      },
                    ),
                  ),
                  const Text('Yes'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.question4.value,
                      onChanged: (String? value) {
                        controller.question4.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(
                height: 27.0,
              ),

              // Blood Pressure
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Do you have any drug allergies?'),
              ),
              Row(
                children: [
                  Obx(
                    () => Radio(
                      value: '1',
                      groupValue: controller.question5.value,
                      onChanged: (String? value) {
                        controller.question5.value = value ?? '1';
                      },
                    ),
                  ),
                  const Text('Yes'),
                  Obx(
                    () => Radio(
                      value: '0',
                      groupValue: controller.question5.value,
                      onChanged: (String? value) {
                        controller.question5.value = value ?? '0';
                      },
                    ),
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(
                height: 27.0,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Obx(() => Text(
                      'Total Price : ${controller.servicePrice.value}',
                      style: regularTextStyle(blackColor),
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Button(
                  text: 'Submit',
                  textColor: whiteColor,
                  onClicked: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirmation'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                      'Are you sure and agree that the information you have filled on the form is original and correct data ?.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Confirm'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Confirm'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )),
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          )),
    );
  }
}
