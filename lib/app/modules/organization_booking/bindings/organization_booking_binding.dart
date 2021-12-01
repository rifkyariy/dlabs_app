import 'package:dlabs_apps/app/modules/organization_booking/controller/organization_controller.dart';
import 'package:get/get.dart';

class OrganizationBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrganizationBookingController>(
      () => OrganizationBookingController(),
    );
  }
}
