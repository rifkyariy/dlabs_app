import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:get/get.dart';

class OrganizationBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());

    Get.lazyPut<OrganizationBookingController>(
      () => OrganizationBookingController(),
    );
  }
}
