import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/models/location_model.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalBookingController extends GetxController {
  final AppStorageService storage = Get.find();
  final MasterDataRepository _masterData = Get.put(MasterDataRepository());

  // Text Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // State
  RxBool isLoading = false.obs;
  RxString genderValue = '0'.obs;

  // Error Message
  RxString fullNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString identityNumberErrorMessage = ''.obs;
  RxString phoneNumberErrorMessage = ''.obs;
  RxString dateOfBirthErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;

  RxString selectedService = '1'.obs;
  List<Map<String, dynamic>> serviceList = [
    {
      'id': '1',
      'value': 'Walk In',
    },
    {
      'id': '2',
      'value': 'Home Services',
    },
    {
      'id': '3',
      'value': 'Drive Thru',
    },
    {
      'id': '4',
      'value': 'Corporate Services',
    },
  ];

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

  late List<dynamic> locationLists;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    _masterData
        .getLocationList(token: await storage.readString('apiToken') ?? '')
        .then((data) {
      var activeLocationLists =
          data.toList().where((element) => element['status'] == 'Active');

      locationLists = data.toList();
    });
  }

  // Validation

  void signUpHandler() async {}
}
