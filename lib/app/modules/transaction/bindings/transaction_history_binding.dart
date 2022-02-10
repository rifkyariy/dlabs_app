import 'package:kayabe_lims/app/data/repository/history_repository.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/repository/transaction_repository.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/auth/controller/auth_controller.dart';
import 'package:kayabe_lims/app/modules/transaction/controller/transaction_view_controller.dart';
import 'package:get/get.dart';

class TransactionHistoryViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionViewController>(() => TransactionViewController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HistoryRepository>(() => HistoryRepository());
    Get.lazyPut<AppStorageService>(() => AppStorageService());
    Get.lazyPut<MasterDataRepository>(() => MasterDataRepository());
    Get.lazyPut<TransactionRepository>(() => TransactionRepository());
  }
}
