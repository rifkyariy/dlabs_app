import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/global_widgets/button.dart';
import 'package:dlabs_apps/app/modules/personal_booking/controller/personal_booking_controller.dart';
// import 'package:select_form_field/select_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Questionnaire extends GetView<PersonalBookingController> {
  Questionnaire({Key? key}) : super(key: key);

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
      body: Container(
        child: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.only(top: 25.0, left: 24.0, right: 24.0),
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.radioData.length,
            itemBuilder: (context, index) => Column(
              children: [
                if (index == 0)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            'Fill this questionnaire to book a test for medical history',
                            style: regularTextStyle(greyColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                SizedBox(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.radioData[index]['questionnaire'],
                      style: regularTextStyle(blackColor),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      groupValue: controller.radioGroupValue[index],
                      value: controller.radioValue[index][0],
                      onChanged: (String? value) {
                        controller.radioGroupValue[index] =
                            value ?? value![index][0];
                        controller.refreshList();
                      },
                    ),
                    const Text('Yes'),
                    Radio(
                      groupValue: controller.radioGroupValue[index],
                      value: controller.radioValue[index][1],
                      onChanged: (String? value) {
                        controller.radioGroupValue[index] =
                            value ?? value![index][1];
                        controller.refreshList();
                      },
                    ),
                    const Text('No'),
                  ],
                ),
              ],
            ),
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
                () => AppButton(
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  elevation: 0,
                                ),
                                child: Text('Confirm',
                                    style: mediumTextStyle(whiteColor)),
                                onPressed: () {
                                  controller.createPersonalBooking();
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
