import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/global_widgets/button.dart';
import 'package:kayabe_lims/app/modules/personal_booking/controller/personal_booking_controller.dart';
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
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
            color: blackColor,
            onPressed: () => Navigator.pop(context)),
        title: Text('qst_questionnaire'.tr, style: BoldTextStyle(blackColor)),
        centerTitle: true,
        elevation: 2.0,
        backgroundColor: whiteColor,
        shadowColor: lightGreyColor,
      ),
      body: SizedBox(
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
                            'qst_subtitle'.tr,
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
                      '${'gen_total_price'.tr} : ${controller.servicePriceString.value}',
                      style: regularTextStyle(blackColor),
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => AppButton(
                  text: 'gen_submit'.tr,
                  textColor: whiteColor,
                  onClicked: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('pop_confirmation'.tr),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('pop_form_confirm'.tr),
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
                                child: Text('pop_cancel'.tr,
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
                                child: Text('pop_confirm'.tr,
                                    style: mediumTextStyle(whiteColor)),
                                onPressed: () {
                                  controller.createPersonalBooking();
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
                  isLoading: controller.isLoading.value,
                ),
              ),
            ],
          )),
    );
  }
}
