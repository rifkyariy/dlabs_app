import 'package:dlabs_apps/app/modules/personal_transaction/controller/transaction_view_controller.dart';
import 'package:get/get.dart';

class TransactionHistoryViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionViewController>(
      () => TransactionViewController(),
    );
  }
}
