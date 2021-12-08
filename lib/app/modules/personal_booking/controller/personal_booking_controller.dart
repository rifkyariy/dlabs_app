import 'package:dlabs_apps/app/data/models/user_model.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/repository/auth_repository.dart';
import 'package:dlabs_apps/app/data/services/currency_formatting.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalBookingController extends GetxController {
  final AppStorageService storage = Get.find();
  final AuthRepository _auth = Get.put(AuthRepository());
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());

  // Text Controllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController testDateController = TextEditingController();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  late String? myIdentityNumber;
  late String? myFullname;
  late String? myEmail;
  late String? myPhoneNumber;
  late String? myDateOfBirth;
  late String? myGender;
  late String? myAddress;
  late String? apiToken;

  RxList<Map<String, dynamic>>? serviceList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? locationList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>>? testTypeList = <Map<String, dynamic>>[].obs;

  // Radio Data
  RxString genderValue = '0'.obs;
  RxString patientSubject = 'myself'.obs;

  RxString question1 = '0'.obs;
  RxString question2 = '0'.obs;
  RxString question3 = '0'.obs;
  RxString question4 = '0'.obs;
  RxString question5 = '0'.obs;

  // Dropdown Data
  TextEditingController selectedService = TextEditingController(text: '1');
  TextEditingController selectedTestPurpose = TextEditingController(text: '1');
  TextEditingController selectedTestType = TextEditingController(text: '1');
  TextEditingController selectedLocation = TextEditingController(text: '1');
  RxString locationAddress = ''.obs;
  RxString servicePrice = '0'.obs;

  // list of purpose list
  List<Map<String, dynamic>> testPurposeList = [
    {
      'id': '1',
      'value': 'Check Up',
    },
    {
      'id': '2',
      'value': 'Make Sure',
    },
  ];

  // State
  RxBool isLoading = false.obs;

  // Error Message
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString identityNumberErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;

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

  // Get List of Services
  Future<List<Map<String, dynamic>>> getListofServices(token) async {
    var result = await _masterData.getServicesList(token: token);
    var api_service_key = ["services_id", "services_name"];

    return convertIntoList(api_service_key, result);
  }

  // Get List of Services
  Future<List<Map<String, dynamic>>> getListofLocation(token) async {
    var result = await _masterData.getLocationList(token: token);
    var api_service_key = ["id", "location_name"];

    return convertIntoList(api_service_key, result);
  }

  Future<List<Map<String, dynamic>>> getListofTypeTest(
      token, locationId) async {
    var result =
        await _masterData.getTypeTestList(token: token, locationId: locationId);
    var api_service_key = ["test_type_id", "nama"];

    return convertIntoList(api_service_key, result);
  }

  // late List<dynamic> locationLists;

  Future<UserModel> getPatientData(token) async {
    try {
      print(token);
      UserModel userData = await _auth.getUserData(token: token);

      return userData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void onInit() async {
    apiToken = await storage.readString('apiToken');
    await getListofServices(apiToken)
        .then((result) => serviceList!.value = result.toList());
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
    });
    toggleFillPatient(); // fill the input based on current user data

    // format test date into today date
    testDateController.text = formatter.format(DateTime.now());

    // Set address description
    _triggerTestTypeandDescription();
    selectedLocation.addListener(_triggerTestTypeandDescription);
    selectedTestType.addListener(_setPrice);

    super.onInit();
  }

  void toggleFillPatient() {
    if (patientSubject == 'myself') {
      fullNameController.text = myFullname ?? '';
      emailController.text = myEmail ?? '';
      idNumberController.text = myIdentityNumber ?? '';
      phoneNumberController.text = myPhoneNumber ?? '';
      dateOfBirthController.text = myDateOfBirth ?? '';
      addressController.text = myAddress ?? '';
      genderValue.value = myGender ?? '0';
    } else {
      fullNameController.text = '';
      emailController.text = '';
      idNumberController.text = '';
      phoneNumberController.text = '';
      dateOfBirthController.text = '';
      addressController.text = '';
      genderValue.value = '0';
    }
  }

  void _triggerTestTypeandDescription() async {
    String id = selectedLocation.text;

    await getListofTypeTest(apiToken, id)
        .then((result) => testTypeList!.value = result.toList());

    selectedTestType.value = TextEditingValue(text: '1');

    var filteredList = locationList!.where((listItem) => listItem['id'] == id);
    locationAddress.value =
        filteredList.toList().elementAt(0)['location_address'];

    _setPrice();
  }

  void _setPrice() {
    var filteredList = testTypeList!
        .where((listItem) => listItem['id'] == selectedTestType.text);

    var price = filteredList.first['price'];

    servicePrice.value = CurrencyFormat.convertToIdr(price, 2);
  }

  void personalBookHandler() async {
    Get.toNamed(AppPages.questionnaire);
  }
}
