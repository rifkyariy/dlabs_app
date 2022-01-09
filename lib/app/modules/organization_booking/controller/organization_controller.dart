import 'dart:convert';

import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:dlabs_apps/app/data/models/patient_model.dart';
import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/repository/booking_repository.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/services/currency_formatting.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:dlabs_apps/app/modules/transaction/views/personal_transaction_detail/transaction_history/transaction_history_view.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// TODO add RX Error for input fields.
// TODO implements service etc api in here.

class OrganizationBookingController extends GetxController {
  final AppStorageService storage = Get.find();
  final AuthRepository _auth = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());
  final BookingRepository _booking = Get.put(BookingRepository());

  // Late variable
  late String? myIdentityNumber;
  late String? myFullname;
  late String? myEmail;
  late String? myPhoneNumber;
  late String? apiToken;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  // Org Text Controller
  final TextEditingController picIdNumberController = TextEditingController();
  final TextEditingController picEmailController = TextEditingController();
  final TextEditingController picPhoneController = TextEditingController();
  final TextEditingController picNameController = TextEditingController();
  final TextEditingController testLocationController = TextEditingController();
  final TextEditingController testDateController = TextEditingController();

  // Search Text Controller
  final TextEditingController searchController = TextEditingController();

  // Patient Text Controller
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

  // List from  API
  RxList<Map<String, dynamic>>? serviceList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? locationList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? testTypeList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? testPurposeList = <Map<String, dynamic>>[].obs;

  // Dropdown Data
  TextEditingController selectedService = TextEditingController(text: '1');
  TextEditingController selectedTestPurpose = TextEditingController(text: '1');
  TextEditingController selectedTestType = TextEditingController(text: '1');
  TextEditingController selectedLocation = TextEditingController(text: '1');

  RxString selectedServiceString = ''.obs;
  RxString locationAddress = ''.obs;
  RxString locationName = ''.obs;

  RxString serviceName = ''.obs;
  RxString servicePrice = '0'.obs;
  RxString servicePriceString = '0'.obs;

  // Focus Node for search
  final FocusNode searchFocusNode = FocusNode();

  // Organization Error Messages
  RxString picIdentityNumberErrorMessage = ''.obs;
  RxString picEmailErrorMessage = ''.obs;
  RxString picPhoneErrorMessage = ''.obs;
  RxString picNameErrorMessage = ''.obs;
  RxString picIdNumberErrorMessage = ''.obs;
  RxDouble totalBookingPrice = 0.0.obs;
  RxString testLocationErrorMessage = ''.obs;

  // Patient Error Message
  RxString identityNumberErrorMessage = ''.obs;
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;
  RxString patientListErrorMessage = ''.obs;

  // States
  RxBool isSearchMode = false.obs;
  RxBool isLoading = false.obs;

  // Search Text
  RxString searchText = ''.obs;

  // DummyList (For testng purposes)
  late RxList<PatientModel> patientList = <PatientModel>[].obs;

  // User search goes here.
  RxList<PatientModel> searchResult = <PatientModel>[].obs;

  // Gender Value
  RxString genderValue = '0'.obs;

  void _triggerLocationAddress() {
    selectedServiceString.value = selectedService.text;

    if (selectedServiceString.value == '1') {
      selectedLocation.value = const TextEditingValue(text: '2');
    } else {
      selectedLocation.value = const TextEditingValue(text: '1');
    }
  }

  // Set Location Description
  void _triggerTestTypeandDescription() async {
    String id = selectedLocation.text;

    await getListofTypeTest(apiToken, id)
        .then((result) => testTypeList!.value = result.toList());

    selectedTestType.value = const TextEditingValue(text: '1');

    var filteredList = locationList!.where((listItem) => listItem['id'] == id);

    locationName.value = filteredList.toList().elementAt(0)['location_name'];
    locationAddress.value =
        filteredList.toList().elementAt(0)['location_address'];
  }

  // Set Price based on Test Type
  void _setPrice() async {
    var filteredList = testTypeList!
        .where((listItem) => listItem['id'] == selectedTestType.text);

    var price = filteredList.first['price'];
    servicePrice.value = price.toString();
    servicePriceString.value = CurrencyFormat.convertToIdr(price, 2);
    // serviceName.value = filteredList.first['nama'];
  }

  // Reusable Function
  List<Map<String, dynamic>> convertIntoList(
      List keyName, List<Map<String, dynamic>> data) {
    var defaultKey = ["id", "value"];

    for (var item in data) {
      for (var i = 0; i < keyName.length; i++) {
        if (item.containsKey(keyName[i])) {
          var value = item[keyName[i]];
          item[defaultKey[i]] = "$value";
        }
      }
    }

    return data;
  }

  // Dynamic Data
  //
  // Get List of Services
  Future<List<Map<String, dynamic>>> getListofServices(token) async {
    var result = await _masterData.getServicesList(token: token);
    var apiServiceKey = ["services_id", "services_name"];

    return convertIntoList(apiServiceKey, result);
  }

  // Get List of Test Purpose
  Future<List<Map<String, dynamic>>> getListofTestPurposes(token) async {
    var result = await _masterData.getTestPurposeList(token: token);
    var apiServiceKey = ["id", "test_purpose"];

    return convertIntoList(apiServiceKey, result);
  }

  // Get List of Services
  Future<List<Map<String, dynamic>>> getListofLocation(token) async {
    var result = await _masterData.getLocationList(token: token);
    var apiServiceKey = ["id", "location_name"];

    return convertIntoList(apiServiceKey, result);
  }

  // Get List of Typetest
  Future<List<Map<String, dynamic>>> getListofTypeTest(
      token, locationId) async {
    var result =
        await _masterData.getTypeTestList(token: token, locationId: locationId);
    var apiServiceKey = ["test_type_id", "nama"];

    return convertIntoList(apiServiceKey, result);
  }

  // Get Patient Data
  Future<void> getPatient({isAll = false}) async {
    await _booking.readPatient(token: apiToken, isAll: isAll).then((result) {
      List<PatientModel> list = [];
      for (var item in result['rows']) {
        list.add(PatientModel.fromJson(item));
      }

      patientList.value = list;

      updateTotalPrice();
    });
  }

  // Get Myself Data
  Future<UserModel> getMyselfData() async {
    try {
      UserModel userData = await _auth.getUserData(token: apiToken!);

      return userData;
    } catch (e) {
      throw e;
    }
  }

  // Set All Dropdown data
  Future<void> getAllDropdownData() async {
    // Fill PIC with myself data
    await getMyselfData().then((result) {
      myIdentityNumber = result.identity_number;
      myFullname = result.full_name;
      myEmail = result.email;
      myPhoneNumber = result.phone;
    });
    toggleFillPIC();

    await getListofServices(apiToken)
        .then((result) => serviceList!.value = result.toList());

    await getListofTestPurposes(apiToken)
        .then((result) => testPurposeList!.value = result.toList());

    await getListofLocation(apiToken)
        .then((result) => locationList!.value = result.toList());

    getPatient(isAll: true);

    // Set address description
    _triggerLocationAddress();
    _triggerTestTypeandDescription();

    selectedService.addListener(_triggerLocationAddress);
    selectedLocation.addListener(_triggerTestTypeandDescription);
  }

  // Add Price Listener
  void addPriceListener() async {
    _setPrice();
    selectedTestType.addListener(_setPrice);
  }

  // Fill PIC input wiht myself data
  void toggleFillPIC() {
    picNameController.text = myFullname ?? '';
    picEmailController.text = myEmail ?? '';
    picIdNumberController.text = myIdentityNumber ?? '';
    picPhoneController.text = myPhoneNumber ?? '';

    // remove all error message
    identityNumberErrorMessage.value = "";
    fullNameErrorMessage.value = "";
    emailErrorMessage.value = "";
    phoneNumberErrorMessage.value = "";
    dateOfBirthErrorMessage.value = "";
    addressErrorMessage.value = "";
    testLocationErrorMessage.value = "";
  }

  // Validating
  bool validateInput() {
    bool isFullNameLengthValid = picNameController.text.length >= 6;
    bool isFullNameValid =
        RegExp(r'[a-zA-Z][a-zA-Z ]+[a-zA-Z]$').hasMatch(picNameController.text);
    bool isIdNumberValid = picIdNumberController.text.length == 16;
    bool isEmailValid = GetUtils.isEmail(picEmailController.text);

    if (picIdNumberController.text != "") {
      if (isIdNumberValid) {
        picIdNumberErrorMessage.value = "";

        if (isEmailValid) {
          picEmailErrorMessage.value = "";

          if (picPhoneController.text != "") {
            picPhoneErrorMessage.value = "";

            if (picNameController.text != "") {
              if (isFullNameLengthValid) {
                if (isFullNameValid) {
                  picNameErrorMessage.value = "";

                  if (patientList.length > 0) {
                    patientListErrorMessage.value = "";
                    // Additional Validation on test location if Myself option is checked
                    // ignore: dead_code
                    if (selectedService.text != '1') {
                      if (testLocationController.text != "") {
                        testLocationErrorMessage.value = "";
                        return true;
                      } else {
                        testLocationErrorMessage.value =
                            "Your location address can\'t be blank";
                      }
                    } else {
                      return true;
                    }
                  } else {
                    patientListErrorMessage.value =
                        "Please enter patient list.";
                  }
                } else {
                  picNameErrorMessage.value = "Please enter valid name.";
                }
              } else {
                picNameErrorMessage.value =
                    "Your full name must be at least 6 characters.";
              }
            } else {
              picNameErrorMessage.value = "Your name can\'t be blank.";
            }
          } else {
            picPhoneErrorMessage.value = "Please enter a valid phone number";
          }
        } else {
          picEmailErrorMessage.value = "Please enter a valid email address.";
        }
      } else {
        picIdNumberErrorMessage.value = "Please enter a valid identity number";
      }
    } else {
      picIdNumberErrorMessage.value = "Please enter a valid identity number";
    }

    return false;
  }

  bool validatePatient() {
    bool isFullNameLengthValid = patientFullNameController.text.length >= 6;
    bool isFullNameValid = RegExp(r'[a-zA-Z][a-zA-Z ]+[a-zA-Z]$')
        .hasMatch(patientFullNameController.text);
    bool isIdNumberValid = patientIDNumberController.text.length == 16;
    bool isEmailValid = GetUtils.isEmail(patientEmailController.text);

    if (patientIDNumberController.text != "") {
      if (isIdNumberValid) {
        identityNumberErrorMessage.value = "";
        if (patientFullNameController.text != "") {
          if (isFullNameLengthValid) {
            if (isFullNameValid) {
              fullNameErrorMessage.value = "";
              if (isEmailValid) {
                emailErrorMessage.value = "";
                if (patientPhoneController.text != "") {
                  phoneNumberErrorMessage.value = "";

                  if (patientDateController.text != "") {
                    dateOfBirthErrorMessage.value = "";

                    if (patientAddressController.text != "") {
                      addressErrorMessage.value = "";

                      return true;
                    } else {
                      addressErrorMessage.value = 'Address can\'t be blank';
                    }
                  } else {
                    dateOfBirthErrorMessage.value =
                        'Date of birth can\'t be blank';
                  }
                } else {
                  phoneNumberErrorMessage.value =
                      "Please enter a valid phone number";
                }
              } else {
                emailErrorMessage.value = "Please enter a valid email address.";
              }
            } else {
              fullNameErrorMessage.value = "Please enter valid name.";
            }
          } else {
            fullNameErrorMessage.value =
                "Your full name must be at least 6 characters.";
          }
        } else {
          fullNameErrorMessage.value = "Your full name can\'t be blank.";
        }
      } else {
        identityNumberErrorMessage.value =
            "Please enter a valid identity number";
      }
    } else {
      identityNumberErrorMessage.value = "Please enter a valid identity number";
    }

    return false;
  }

  // Init
  @override
  void onInit() async {
    // format test date into today date
    testDateController.text = formatter.format(DateTime.now());

    // async data
    apiToken = await storage.readString('apiToken');
    getAllDropdownData();

    // patientList.value = _generatedItems;

    super.onInit();
  }

  // handle submit
  void organizationBookHandler() async {
    if (validateInput()) {
      var selectedServiceName = serviceList!
          .where((listItem) => listItem['id'] == selectedService.text);

      var selectedTestPurposeName = testPurposeList!
          .where((listItem) => listItem['id'] == selectedTestPurpose.text);

      var payload = {
        "transaction_detail": {
          "services": selectedServiceName.first['services_name'],
          "myself": 'other',
          "identity_number": picIdNumberController.text,
          "name": picNameController.text,
          "email": picEmailController.text,
          "phone": picPhoneController.text,
          "test_date": testDateController.text,
          "location_name": locationName.value,
          "location_address": selectedService.text == '1'
              ? locationAddress.value
              : testLocationController.text,
          "test_purpose": selectedTestPurposeName.first['test_purpose']
        },
      };

      isLoading.value = true;
      if (await _booking.createOrganizationBooking(
          payload: payload, token: apiToken!)) {
        isLoading.value = false;
        // Redirect into sign in page
        Get.off(
          () => const TransactionHistoryView(),
          binding: TransactionHistoryViewBinding(),
        );

        // Display success snackbar
        Get.snackbar(
          'Success',
          'Your Transaction is ready.',
          backgroundColor: Colors.lightGreen,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  // Add and Update Controller
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

    Map selectedTestTypeMap = testTypeList!
        .where((listItem) => listItem['id'] == selectedTestType.text)
        .first;

    _patient.identityNumber = patientIDNumberController.text;
    _patient.fullName = patientFullNameController.text;
    _patient.email = patientEmailController.text;
    _patient.phoneNumber = patientPhoneController.text;
    _patient.dateOfBirth = patientDateController.text;
    _patient.gender = patientGenderController.text;
    _patient.address = patientAddressController.text;
    _patient.testPrice = double.parse("${selectedTestTypeMap['price']}");
    _patient.testType = selectedTestTypeMap['value'].toString();
    _patient.testTypeId = selectedTestType.text;

    // Payload for update via API
    var payload = {
      "id": _patient.id,
      "identity_number": _patient.identityNumber,
      "name": _patient.fullName,
      "email": _patient.email,
      "phone": _patient.phoneNumber,
      "date_of_birth": _patient.dateOfBirth,
      "gender": _patient.gender,
      "address": _patient.address,
      "test_type": _patient.testTypeId,
      // "nationality": _patient.nationality TODO ini juga gaada nationality
    };

    // update on API
    updatePatientDataOnDB(payload);

    // Refresh used to trigger OBX that the List Item has been changed.
    patientList.refresh();
  }

  void updatePatientDataOnDB(payload) async {
    isLoading.value = true;
    if (await _booking.updatePatient(payload: payload, token: apiToken!)) {
      isLoading.value = false;
      // Redirect into sign in page
      Get.toNamed(AppPages.organizationBooking);

      // Display success snackbar
      Get.snackbar(
        'Success',
        'Update patient data success.',
        backgroundColor: Colors.lightGreen,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void deletePatient(int index) {
    deletePatientDataOnDB(index);
    patientList.removeAt(index);
    print(index);

    // Update the price
    updateTotalPrice();
  }

  void deletePatientDataOnDB(int index) async {
    var _patient = patientList.elementAt(index);
    var payload = {'id': _patient.id};

    if (await _booking.deletePatient(payload: payload, token: apiToken!)) {
      // Display success snackbar
      Get.snackbar(
        'Success',
        'Patient data has been deleted.',
        backgroundColor: Colors.lightGreen,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
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
    selectedTestType.text = _patient.testTypeId;

    // TODO add test type and test price to here
  }

  /// Still so much error on this
  /// TODO change this test price and test type thingis
  /// Need to meet to discuss about this.
  /// Still need lot of reconstruction
  /// WARNING this is just testing.
  onAddPatient() {
    // validating patient form
    if (validatePatient()) {
      // check if id and test type was same

      Map selectedTestTypeMap = testTypeList!
          .where((listItem) => listItem['id'] == selectedTestType.text)
          .first;

      // Remove error message
      patientListErrorMessage.value = "";

      var payload = {
        "test_type": selectedTestType.text,
        "identity_number": patientIDNumberController.text,
        "name": patientFullNameController.text,
        "email": patientEmailController.text,
        "phone": patientPhoneController.text,
        "date_of_birth": patientDateController.text,
        "gender": genderValue.value,
        "address": patientAddressController.text
      };

      addPatientOnDB(payload, selectedTestTypeMap);

      // // locally add
      // patientList.add(
      //   PatientModel(
      //     fullName: patientFullNameController.text,
      //     address: patientAddressController.text,
      //     dateOfBirth: patientDateController.text,
      //     email: patientEmailController.text,
      //     gender: patientGenderController.text,
      //     identityNumber: patientIDNumberController.text,
      //     phoneNumber: patientPhoneController.text,
      //     testTypeId: selectedTestType.text,
      //     testPrice: double.parse("${selectedTestTypeMap['price']}"),
      //     testType: selectedTestTypeMap['value'].toString(),
      //   ),
      // );

      return true;
    } else {
      return false;
    }
  }

  void addPatientOnDB(payload, selectedTestTypeMap) async {
    try {
      await _booking.addPatient(payload: payload, token: apiToken);

      // Refresh patient list
      getPatient(isAll: true);
      patientList.refresh();

      Get.toNamed(AppPages.organizationBooking);

      // Display success snackbar
      Get.snackbar(
        'Success',
        'Patient Has Been Added',
        backgroundColor: Colors.lightGreen,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      if (e.toString().contains('User Identity number already used')) {
        // Display Error snackbar
        Get.snackbar(
          'Error',
          'Identity Number with Test Type (${selectedTestTypeMap["value"].toString()}) is already used',
          backgroundColor: dangerColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        // Display Error snackbar
        Get.snackbar(
          'Oops',
          'Something went wrong',
          backgroundColor: dangerColor,
          colorText: whiteColor,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  // Generate dummy data for testing purposes
  final _generatedItems = List<PatientModel>.generate(
    3,
    (i) {
      return PatientModel(
          id: 0,
          identityNumber: UniqueKey().toString(),
          fullName: "Annisa Putri jati $i",
          email: "ajwadax@gmail.com",
          phoneNumber: "082313078170",
          dateOfBirth: "27-06-2001",
          gender: "1",
          address:
              "Some Place In the world that people already know, new york maybe",
          testType: "Swab Antigen",
          testPrice: 75000.0,
          testTypeId: '1',
          nationality: 'Indonesian');
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
    selectedTestType = TextEditingController(text: '1');
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
