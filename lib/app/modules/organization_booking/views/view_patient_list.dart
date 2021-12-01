import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:dlabs_apps/app/modules/organization_booking/local_widgets/booking_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class ViewPatientList extends StatelessWidget {
  final OrganizationBookingController controller = Get.put(
    OrganizationBookingController(),
  );

  ViewPatientList({
    Key? key,
  }) : super(key: key);

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
          'Patient List',
          style: BoldTextStyle(
            const Color(0xFF323F4B),
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
        backgroundColor: Colors.white,
        shadowColor: lightGreyColor,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: primaryColor),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          semanticChildCount: controller.dummyList.length,
          shrinkWrap: true,
          itemCount: controller.dummyList.length,
          itemBuilder: (context, index) {
            return BookingListTile(
              key: Key(index.toString()),
              title: controller.dummyList[index].fullName,
              subtitle: 'ID No : ${controller.dummyList[index].identityNumber}',
              deleteButtonPressed: (context) {
                controller.dummyList.removeAt(index);
                controller.updateTotalPrice();
              },
            );
          },
        ),
      ),
    );
  }
}
