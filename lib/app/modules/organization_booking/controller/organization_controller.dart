import 'package:dlabs_apps/app/data/models/patient_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// TODO add RX Error for input fields.
// TODO implements service etc api in here.
//

class OrganizationBookingController extends GetxController {
  // Text Controller
  // .....
  final TextEditingController picIdNumberController = TextEditingController();
  final TextEditingController picEmailController = TextEditingController();
  final TextEditingController picPhoneController = TextEditingController();
  final TextEditingController picNameController = TextEditingController();
  final TextEditingController testDateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController patientIDNumberController =
      TextEditingController();
  final TextEditingController patientEmailController = TextEditingController();
  final TextEditingController patientPhoneController = TextEditingController();
  final TextEditingController patientDateController = TextEditingController();
  final TextEditingController patientGenderController = TextEditingController();
  final TextEditingController patientAddressController =
      TextEditingController();
  final TextEditingController patientTestTypeController =
      TextEditingController();
  final TextEditingController identityNumberController =
      TextEditingController();
  final TextEditingController patientFullNameController =
      TextEditingController();

  // Focus Node for search
  final FocusNode searchFocusNode = FocusNode();

  // Error Messages
  RxString picIdNumberErrorMessage = ''.obs;
  RxDouble totalBookingPrice = 0.0.obs;

  // States
  RxBool isSearchMode = false.obs;

  // Search Text
  RxString searchText = ''.obs;

  // DummyList (For testng purposes)
  late RxList<PatientModel> patientList = <PatientModel>[].obs;

  // User search goes here.
  RxList<PatientModel> searchResult = <PatientModel>[].obs;

  // Gender Value
  RxString genderValue = '0'.obs;

  // TODO Change this to dynamic using API, this is only for testing purposes
  // Test Type DropDown Selected Item
  // Still buggy, cant be used, price on UI not updated when it should be updated
  RxString testTypeSelected = '1'.obs;
  RxList<Map<String, dynamic>> testTypeItems = [
    {'id': '1', 'value': 'SWAB Antigen', 'price': 1000000.0},
    {'id': '2', 'value': 'PCR', 'price': 750000.0},
    {'id': '3', 'value': 'Rapid Antigen', 'price': 75000.0},
  ].obs;

  // Init
  @override
  void onInit() {
    super.onInit();

    updateTotalPrice();
  }

  // Get index based on patient ID
  int patientDataIndex(String patientID) {
    return patientList.indexWhere(
      (patient) => patient.identityNumber == patientID,
    );
  }

  // Update total price on UI
  void updateTotalPrice() {
    totalBookingPrice.value = patientList.fold(0, (p, c) => p + c.testPrice);
  }

  // Handle search done by user
  void onSearch(String search) {
    searchResult.clear();
    // Set SearchTextvalue to search text on UI

    searchText.value = search;
    if (search == '') {
      searchResult.clear();
      return;
    }
    for (PatientModel patient in patientList) {
      if (patient.fullName.toLowerCase().contains(search.toLowerCase())) {
        searchResult.add(patient);
      }
    }
  }

  /// Update patient data based on index
  /// Get the update data from text controller.
  ///
  void updatePatientData(
    int index, {
    required RxList<PatientModel> list,
    required bool onSearch,
  }) {
    var _patient = list.elementAt(index);

    _patient.identityNumber = patientIDNumberController.text;
    _patient.fullName = patientFullNameController.text;
    _patient.email = patientEmailController.text;
    _patient.phoneNumber = patientPhoneController.text;
    _patient.dateOfBirth = patientDateController.text;
    _patient.gender = patientGenderController.text;
    _patient.address = patientAddressController.text;
    // TODO add patient type and price to here

    // Refresh used to trigger OBX that the List Item has been changed.
    patientList.refresh();
  }

  /// Update text controller on update page based on [patientList].elementAt(index)
  /// This is responsible for update page data.
  void updateTextControllerBasedOnIndex(int index) {
    var _patient = patientList.elementAt(index);

    patientIDNumberController.text = _patient.identityNumber;
    patientFullNameController.text = _patient.fullName;
    patientEmailController.text = _patient.email;
    patientPhoneController.text = _patient.phoneNumber;
    patientDateController.text = _patient.dateOfBirth;
    patientGenderController.text = _patient.gender;
    patientAddressController.text = _patient.address;

    // TODO add test type and test price to here
  }

  /// Still so much error on this
  /// TODO change this test price and test type thingis
  /// Need to meet to discuss about this.
  /// Still need lot of reconstruction
  /// WARNING this is just testing.
  void onAddPatient() {
    patientList.add(
      PatientModel(
        fullName: patientFullNameController.text,
        address: patientAddressController.text,
        dateOfBirth: patientDateController.text,
        email: patientEmailController.text,
        gender: patientGenderController.text,
        identityNumber: patientIDNumberController.text,
        phoneNumber: patientPhoneController.text,
        testPrice: testTypeItems[0]['price'],
        testType: testTypeItems[0]['value'],
      ),
    );
  }
  //TODO implement onAddPatient here instead of use in outside.

  // Generate dummy data for testing purposes
  final _generatedItems = List<PatientModel>.generate(
    3,
    (i) {
      return PatientModel(
        identityNumber: UniqueKey().toString(),
        fullName: "Annisa Putri jati $i",
        email: "ajwadax@gmail.com",
        phoneNumber: "082313078170",
        dateOfBirth: "27-06-2001",
        gender: "1",
        address:
            "Some Place In the world that people already know, new york maybe",
        testType: "Swab Antigen",
        testPrice: 100000.0,
      );
    },
  );

  void clearTextController() {
    patientIDNumberController.clear();
    patientFullNameController.clear();
    patientEmailController.clear();
    patientPhoneController.clear();
    patientDateController.clear();
    patientGenderController.clear();
    patientAddressController.clear();
  }

  // Dispose any controller.
  @override
  void onClose() {
    super.onClose();
    picIdNumberController.dispose();
    picEmailController.dispose();
    picPhoneController.dispose();
    picNameController.dispose();
    testDateController.dispose();
    searchController.dispose();
    patientEmailController.dispose();
    patientPhoneController.dispose();
    patientDateController.dispose();
    patientGenderController.dispose();
    patientAddressController.dispose();
    patientTestTypeController.dispose();
    identityNumberController.dispose();
    patientFullNameController.dispose();
    searchFocusNode.dispose();
  }
}
