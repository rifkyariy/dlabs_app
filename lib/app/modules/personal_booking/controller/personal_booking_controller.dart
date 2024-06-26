import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/models/user_model.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/repository/booking_repository.dart';
import 'package:kayabe_lims/app/data/repository/auth_repository.dart';
import 'package:kayabe_lims/app/data/services/currency_formatting.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:kayabe_lims/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalBookingController extends GetxController {
  final AppStorageService storage = Get.find();
  final TransactionViewController transactionViewController = Get.find();
  final AuthRepository _auth = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());
  final BookingRepository _booking = Get.put(BookingRepository());

  // Text Controllers
  TextEditingController idNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController testLocationController = TextEditingController();
  TextEditingController testDateController = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:MM:ss');

  // My Data
  late String? myIdentityNumber;
  late String? myFullname;
  late String? myEmail;
  late String? myPhoneNumber;
  late String? myDateOfBirth;
  late String? myGender;
  late String? myAddress;
  late String myNationality;

  // Other Search Data
  late String? searchFullname;
  late String? searchEmail;
  late String? searchPhoneNumber;
  late String? searchDateOfBirth;
  late String? searchGender;
  late String? searchAddress;
  late String searchNationality;
  late String? apiToken;

  RxList<Map<String, dynamic>>? serviceList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? locationList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? testTypeList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? testPurposeList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? nationalityList = <Map<String, dynamic>>[].obs;

  // Radio Data
  RxString genderValue = '0'.obs;
  RxString patientSubject = 'myself'.obs;

  // Dropdown Data
  TextEditingController selectedService = TextEditingController(text: '1');
  TextEditingController selectedTestPurpose = TextEditingController(text: '1');
  TextEditingController selectedTestType = TextEditingController(text: '1');
  TextEditingController selectedLocation = TextEditingController(text: '1');
  late TextEditingController selectedNationality;

  RxBool isLoaded = false.obs;
  RxString selectedNationalityString = ''.obs;
  RxString selectedServiceString = ''.obs;
  RxString locationAddress = ''.obs;
  RxString locationName = ''.obs;

  RxString serviceName = ''.obs; // test_type_name
  RxString servicePrice = '0'.obs;
  RxString servicePriceString = '0'.obs;

  // State
  RxBool isLoading = false.obs;

  // Error Message
  RxString identityNumberErrorMessage = ''.obs;
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;
  RxString testLocationErrorMessage = ''.obs;

  // Questionnaire
  RxList<Map<String, dynamic>> radioData = <Map<String, dynamic>>[].obs;
  RxList<String> radioGroupValue = <String>[].obs;
  RxList<List<String>> radioValue = <List<String>>[].obs;

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

  // Get List of Nationality
  Future<List<Map<String, dynamic>>> getListofNationality() async {
    var result = await _masterData.getNationalityList();
    var apiServiceKey = ["id", "nationality"];

    return convertIntoList(apiServiceKey, result);
  }

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

  Future<List<Map<String, dynamic>>> getListofTypeTest(
      token, locationId) async {
    var result =
        await _masterData.getTypeTestList(token: token, locationId: locationId);
    var apiServiceKey = ["test_type_id", "nama"];

    return convertIntoList(apiServiceKey, result);
  }

  Future getQuestionnaire(token, testTypeId) async {
    var result = await _masterData.getQuestionnaire(
        token: token, testTypeId: testTypeId);

    return result;
  }

  Future<UserModel> getPatientData(token) async {
    try {
      UserModel userData = await _auth.getUserData(token: token);

      return userData;
    } catch (e) {
      throw e;
    }
  }

  @override
  void onInit() async {
    apiToken = await storage.readString('apiToken');

    await getListofServices(apiToken)
        .then((result) => serviceList!.value = result.toList());

    await getListofNationality()
        .then((result) => nationalityList!.value = result.toList());

    await getListofTestPurposes(apiToken)
        .then((result) => testPurposeList!.value = result.toList());

    await getListofLocation(apiToken)
        .then((result) => locationList!.value = result.toList());

    // Get current user data as patient
    await getPatientData(apiToken).then((result) {
      myIdentityNumber = result.identity_number;
      myFullname = result.full_name;
      myEmail = result.email;
      myPhoneNumber = result.phone;
      myDateOfBirth = result.birth_date;
      myGender = result.gender;
      myAddress = result.address;
      myNationality = result.nationality!;
      selectedNationality = TextEditingController(text: myNationality);
      isLoaded.value = true;
    });

    // fill the input based on current user data
    await toggleFillPatient();

    // format test date into today date
    testDateController.text = formatter.format(DateTime.now());

    // Set address description
    _triggerLocationAddress();
    _triggerTestTypeandDescription();

    selectedService.addListener(_triggerLocationAddress);
    selectedLocation.addListener(_triggerTestTypeandDescription);
    selectedTestType.addListener(_setPrice);
    idNumberController.addListener(_searchPatientData);

    super.onInit();
  }

  // Set form based on personal information of user
  // Current user is Myself
  Future<void> toggleFillPatient() async {
    if (patientSubject.value == 'myself') {
      fullNameController.text = myFullname ?? '';
      emailController.text = myEmail ?? '';
      idNumberController.text = myIdentityNumber ?? '';
      phoneNumberController.text = myPhoneNumber ?? '';
      dateOfBirthController.text = myDateOfBirth ?? '';
      addressController.text = myAddress ?? '';
      genderValue.value = myGender ?? '0';
      selectedNationality.text = myNationality;
      selectedNationality = TextEditingController(text: myNationality);

      // remove all error message
      identityNumberErrorMessage.value = "";
      fullNameErrorMessage.value = "";
      emailErrorMessage.value = "";
      phoneNumberErrorMessage.value = "";
      dateOfBirthErrorMessage.value = "";
      addressErrorMessage.value = "";
      testLocationErrorMessage.value = "";
    } else {
      fullNameController.text = '';
      emailController.text = '';
      idNumberController.text = '';
      phoneNumberController.text = '';
      dateOfBirthController.text = '';
      addressController.text = '';
      testLocationController.text = '';
      genderValue.value = '0';
      selectedNationality.text = 'Indonesian';
    }
  }

  // Set location
  void _triggerLocationAddress() async {
    selectedServiceString.value = selectedService.text;
    setLocationByService(selectedServiceString.value);
  }

  void setLocationByService(serviceId) async {
    if (serviceId == '1') {
      selectedLocation.value = const TextEditingValue(text: '2');

      await getListofLocation(apiToken).then((result) => locationList!.value =
          result.where((element) => element['id'] != '1').toList());
    } else {
      await getListofLocation(apiToken)
          .then((result) => locationList!.value = result.toList());
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

    _setPrice();
  }

  // Set Price based on Test Type
  void _setPrice() {
    var filteredList = testTypeList!
        .where((listItem) => listItem['id'] == selectedTestType.text);

    var price = filteredList.first['price'];
    servicePrice.value = price.toString();
    servicePriceString.value = CurrencyFormat.convertToIdr(price, 2);
    serviceName.value = filteredList.first['nama'];
  }

  void _searchPatientData() async {
    String q = idNumberController.text;
    if (q.length >= 3) {
      try {
        await _masterData.getPatientData(token: apiToken!, idNumber: q).then(
          (result) {
            fullNameController.text = result['full_name'];
            emailController.text = result['email'];
            phoneNumberController.text = result['phone'];
            dateOfBirthController.text = result['birth_date'];
            addressController.text = result['address'];
            genderValue.value = result['gender'];
            selectedNationality.text = result['nationality'];

            reloadDropdown();
          },
        );
      } catch (e) {
        fullNameController.text = '';
        emailController.text = '';
        phoneNumberController.text = '';
        dateOfBirthController.text = '';
        addressController.text = '';
        testLocationController.text = '';
        genderValue.value = '0';
        reloadDropdown();
      }
    }
  }

  // Refresh Questionnire list
  void refreshList() {
    radioGroupValue.refresh();
    radioValue.refresh();
    radioData.refresh();
  }

  void reloadDropdown() {
    // Reload Dropdown
    isLoaded.value = false;
    isLoaded.value = true;
  }

  void disposeAll() {
    idNumberController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    testLocationController.dispose();
    testDateController.dispose();
    selectedService.dispose();
    selectedTestPurpose.dispose();
    selectedTestType.dispose();
    selectedLocation.dispose();
    selectedNationality.dispose();
  }

  void personalBookHandler() async {
    bool isFullNameLengthValid = fullNameController.text.length >= 6;
    bool isFullNameValid = RegExp(r'[a-zA-Z][a-zA-Z ]+[a-zA-Z]$')
        .hasMatch(fullNameController.text);
    bool isEmailValid = GetUtils.isEmail(emailController.text);

    if (idNumberController.text != "") {
      identityNumberErrorMessage.value = "";
      if (!GetUtils.isNull(fullNameController.text)) {
        if (isFullNameLengthValid) {
          if (isFullNameValid) {
            fullNameErrorMessage.value = "";
            if (isEmailValid) {
              emailErrorMessage.value = "";
              if (phoneNumberController.text != "") {
                phoneNumberErrorMessage.value = "";

                if (dateOfBirthController.text != "") {
                  dateOfBirthErrorMessage.value = "";

                  if (addressController.text != "") {
                    addressErrorMessage.value = "";

                    // Additional Validation on test location if Myself option is checked
                    if (selectedService.text != '1') {
                      if (testLocationController.text != "") {
                        testLocationErrorMessage.value = "";
                        buildQuestionnaireView();
                      } else {
                        testLocationErrorMessage.value =
                            "Your location address can\'t be blank";
                      }
                    } else {
                      buildQuestionnaireView();
                    }
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
      identityNumberErrorMessage.value = "Please enter a valid identity number";
    }
  }

  void buildQuestionnaireView() async {
    // Get List of Questionnaire
    var questionnaire = await getQuestionnaire(apiToken, selectedTestType.text);
    if (questionnaire.length > 0) {
      radioData.value = questionnaire;

      // Set default value of questionnaire
      // Default value = 0 or No
      for (var i = 0; i < questionnaire.length; i++) {
        radioGroupValue.add('0');
        radioValue.add(['1', '0']);
      }

      // Redirect into Questionnaire View
      Get.toNamed(AppPages.questionnaire);
    } else {
      radioData.value = <Map<String, dynamic>>[];

      Get.dialog(
        AlertDialog(
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
                        side: BorderSide(width: 1, color: greyColor)),
                    child: Text('Cancel', style: mediumTextStyle(greyColor)),
                    onPressed: () {
                      Get.back();
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
                    child: Text('Confirm', style: mediumTextStyle(whiteColor)),
                    onPressed: () {
                      createPersonalBooking();
                      Get.back();
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
      );
    }
  }

  void createPersonalBooking() async {
    // Convert Questionnaire into Yes/No Answer
    String convertIntoQuestionAnswer(value) {
      return value == '1' ? 'Yes' : 'No';
    }

    // Insert radio value into Questionnaire Object
    print(radioData.length);
    for (var i = 0; i < radioData.length; i++) {
      radioData[i]['jawaban'] = convertIntoQuestionAnswer(radioGroupValue[i]);
    }

    List questionnaire = [];
    questionnaire = radioData;

    var selectedServiceName = serviceList!
        .where((listItem) => listItem['id'] == selectedService.text);

    var selectedTestPurposeName = testPurposeList!
        .where((listItem) => listItem['id'] == selectedTestPurpose.text);

    // Payload send to API
    var payload = {
      "transaction_detail": {
        "services": selectedServiceName.first['services_name'],
        "type_test_id": int.parse(selectedTestType.text),
        "myself": patientSubject.value,
        "identity_number": myIdentityNumber,
        "name": myFullname,
        "email": myEmail,
        "phone": myPhoneNumber,
        "test_date": testDateController.text,
        "location_name": locationName.value,
        "location_address": selectedService.text == '1'
            ? locationAddress.value
            : testLocationController.text,
        "price": int.parse(servicePrice.value),
        "gender": myGender,
        "birth_date": myDateOfBirth,
        "address": myAddress,
        "test_purpose": selectedTestPurposeName.first['test_purpose']
      },
      "patient_list": {
        "services": selectedServiceName.first['services_name'],
        "identity_number": idNumberController.text,
        "nationality": selectedNationality.text,
        "full_name": fullNameController.text,
        "email": emailController.text,
        "phone": phoneNumberController.text,
        "birth_date": dateOfBirthController.text,
        "gender": genderValue.value,
        "address": addressController.text,
        "test_type": serviceName.value,
        "kuisioner": questionnaire
      }
    };

    isLoading.value = true;
    try {
      var result = await _booking.createPersonalBooking(
          payload: payload, token: apiToken!);

      isLoading.value = false;

      // Dispose all text editing controller
      // disposeAll();

      // Display success snackbar
      Get.snackbar(
        'Success',
        'Your Transaction is ready.',
        backgroundColor: Colors.lightGreen,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );

      // refresh transaction history
      transactionViewController.refreshHistoryList();

      String transactionId = result['transaction_detail']['transaction_id'];
      transactionViewController.onTransactionCardPressed(
          transactionId: transactionId,
          status: TRANSACTIONSTATUS.newTransaction,
          isDestroyState: true);
    } catch (e) {
      // Display success snackbar
      Get.snackbar(
        'Error',
        '${e}',
        backgroundColor: dangerColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
