import 'package:dlabs_apps/app/data/repository/history_repository.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:get/get.dart';

class TransactionHistoryViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionViewController>(() => TransactionViewController());
    Get.lazyPut<HistoryRepository>(() => HistoryRepository());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());
  }
}
