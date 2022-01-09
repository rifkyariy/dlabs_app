import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:kayabe_lims/app/modules/organization_booking/local_widgets/booking_list_tile.dart';
import 'package:kayabe_lims/app/modules/organization_booking/views/add_or_update_patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    // Custom App Bar.
    // Used to get the preferedSized height.

    AppBar appBar(bool centeredTitle) => AppBar(
          //...
          // IF search mode == true then leading is Null to give space to text field
          // IT has to be null because if its a widget then there will be default padding.
          leading: controller.isSearchMode.value
              ? null
              // OBX is wrapped in here because OBX wont let us return null, so instead of creating
              // obx in leading, we created obx in here.
              // ...
              // If search mode == true leading return SizedBox() else return back arrow.
              : Obx(
                  () => controller.isSearchMode.value
                      ? const SizedBox()
                      : IconButton(
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                          color: const Color(0xFF1176BC),
                          onPressed: () => Navigator.pop(context),
                        ),
                ),

          // Title is the center widget on appBar
          title: Obx(
            // IF searchMode == true then return Textfield with 32 height.
            () => controller.isSearchMode.value
                ? Container(
                    height: 32,
                    alignment: Alignment.centerLeft,

                    // App bar text field component
                    // This appear when isSearchMode == ture
                    child: TextField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocusNode,

                      // Textfield Decoration
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEBF0FF),
                            width: 0.5,
                          ),
                        ),
                        suffixIcon: IconButton(
                          //...
                          // Clear Button is here
                          onPressed: () {
                            // Clear the textfield controller.
                            controller.searchController.clear();
                            // Call onSearch Method to refresh the list.
                            controller.onSearch('');
                          },
                          icon: Icon(
                            Icons.cancel,
                            size: 16,
                            color: greyColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          bottom: 16,
                          left: 10,
                        ),
                      ),

                      // On changed responsible to call search method on controller.
                      // Will call everytime there change in textfield
                      onChanged: (value) {
                        controller.onSearch(controller.searchController.text);
                      },
                    ),
                  )

                // if searchMode == false
                // Return title in middle.
                : Text(
                    'Patient List',
                    style: BoldTextStyle(
                      const Color(0xFF323F4B),
                    ),
                  ),
          ),
          actions: [
            // If searchmode == true return Done button.
            // else return search icon button
            Obx(
              () => controller.isSearchMode.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text(
                            'Done',
                            style: BoldTextStyle(primaryColor),
                          ),
                          onTap: () {
                            // Change searchMode value
                            controller.isSearchMode.value = false;
                            controller.searchController.clear();
                            controller.searchFocusNode.unfocus();
                            controller.onSearch('');
                          },
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.search, color: primaryColor),
                      tooltip: 'Search',
                      onPressed: () {
                        // Change searchMode value
                        controller.isSearchMode.value = true;
                        controller.searchFocusNode.requestFocus();
                      },
                    ),
            )
          ],
          centerTitle: centeredTitle,
          elevation: 2.0,
          backgroundColor: Colors.white,
          shadowColor: lightGreyColor,
          automaticallyImplyLeading: false,
        );

    // Scaffold Component Sialan sek nduwur njelei banget sakestu.

    return Scaffold(
      appBar: PreferredSize(
        child: Obx(
          () => controller.isSearchMode.value ? appBar(false) : appBar(true),
        ),
        preferredSize: Size.fromHeight(
          appBar(true).preferredSize.height,
        ),
      ),
      body: Obx(
        () => controller.searchText.value.isEmpty &&
                controller.searchResult.isEmpty
            ? ListView.builder(
                semanticChildCount: controller.patientList.length,
                itemCount: controller.patientList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BookingListTile(
                    key: Key(controller.patientList[index].identityNumber),
                    title: controller.patientList[index].fullName,
                    subtitle:
                        'ID No : ${controller.patientList[index].identityNumber}',
                    deleteButtonPressed: (context) {
                      // TODO add alert button
                      // Delete Button Pressed
                      // Remove dummyList at x index
                      controller.deletePatient(index);
                    },
                    updateButtonPressed: (context) {
                      controller.updateTextControllerBasedOnIndex(index);
                      Get.to(
                        () => AddOrUpdatePatient(
                          onSearch: false,
                          isUpdateMode: true,
                          updateIndex: index,
                        ),
                      );
                    },
                  );
                },
              )
            : controller.searchResult.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    semanticChildCount: controller.searchResult.length,
                    itemCount: controller.searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BookingListTile(
                        key: Key(controller.searchResult[index].identityNumber),
                        title: controller.searchResult[index].fullName,
                        subtitle:
                            'ID No : ${controller.searchResult[index].identityNumber}',
                        deleteButtonPressed: (context) {
                          // Get index with spesicfic identity Number
                          int idx = controller.patientDataIndex(
                              controller.searchResult[index].identityNumber);

                          // Remove search result data on x index
                          // Remove patient data on x index

                          controller.searchResult.removeAt(index);
                          controller.deletePatient(idx);
                        },
                        updateButtonPressed: (context) {
                          int idx = controller.patientDataIndex(
                              controller.searchResult[index].identityNumber);
                          controller.updateTextControllerBasedOnIndex(idx);
                          Get.to(
                            () => AddOrUpdatePatient(
                              onSearch: true,
                              isUpdateMode: true,
                              updateIndex: index,
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
