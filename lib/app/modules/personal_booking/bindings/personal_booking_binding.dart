import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/personal_booking/controller/personal_booking_controller.dart';
import 'package:get/get.dart';

class PersonalBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());
    Get.lazyPut<PersonalBookingController>(() => PersonalBookingController());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
  }
}
