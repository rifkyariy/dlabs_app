import 'package:dlabs_apps/app/data/models/patient_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OrganizationBookingController extends GetxController {
  // Text Controller
  final TextEditingController picIdNumberController = TextEditingController();
  final TextEditingController picEmailController = TextEditingController();
  final TextEditingController picPhoneController = TextEditingController();
  final TextEditingController picNameController = TextEditingController();
  final TextEditingController testDateController = TextEditingController();
  final TextEditingController identityNumberController =
      TextEditingController();
  final TextEditingController patientFullNameController =
      TextEditingController();
  final TextEditingController patientEmailController = TextEditingController();
  final TextEditingController patientPhonrController = TextEditingController();
  final TextEditingController patientDateController = TextEditingController();
  final TextEditingController patientGenderController = TextEditingController();
  final TextEditingController patientAddressController =
      TextEditingController();
  final TextEditingController patientTestTypeController =
      TextEditingController();

  // Error Messages
  RxString picIdNumberErrorMessage = ''.obs;
  RxDouble totalBookingPrice = 0.0.obs;

  // States
  RxBool isSearchMode = false.obs;

  final _generatedItems = List<PatientModel>.generate(
    5,
    (i) => PatientModel(
      identityNumber: "3026725364789172",
      fullName: "Annisa Putri jati $i",
      email: "ajwadax@gmail.com",
      phoneNumber: "082313078170",
      dateOfBirth: "27-06-2001",
      gender: "1",
      address:
          "Some Place In the world that people already know, new york maybe",
      testType: "Swab Antigen",
      testPrice: 100000.0,
    ),
  );

  late RxList<PatientModel> dummyList = _generatedItems.obs;

  void updateTotalPrice() {
    totalBookingPrice.value = dummyList.fold(0, (p, c) => p + c.testPrice);
    update();
  }

  @override
  void onInit() {
    super.onInit();

    updateTotalPrice();
  }
}

onSearch(List<String> list, String search) {
  list.forEach(
    (element) {
      if (element.contains(search)) {
        searchResult.add(element);
      }
    },
  );
}

List<String> searchResult = [];
