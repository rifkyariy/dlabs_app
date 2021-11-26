import 'package:dlabs_apps/app/modules/personal_booking/controller/personal_booking_controller.dart';
import 'package:get/get.dart';

class PersonalBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalBookingController>(() => PersonalBookingController());
  }
}
