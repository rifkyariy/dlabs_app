import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/data/models/transaction.dart';
import 'package:dlabs_apps/app/data/models/trx_history_model/trx_history_row.dart';
import 'package:dlabs_apps/app/data/repository/history_repository.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:get/get.dart';

class TransactionViewController extends GetxController {
  final AppStorageService _storage = Get.find();
  final HistoryRepository _historyRepository = Get.find();
  final MasterDataRepository _masterData = Get.find();

  late String? _apiToken;

  RxList<TrxHistoryRow> history = <TrxHistoryRow>[].obs;
  RxList<Map<String, dynamic>> serviceList = <Map<String, dynamic>>[].obs;
  RxList<Transaction> transactions = <Transaction>[].obs;

  @override
  void onInit() async {
    getHistoryRowList();
    getServiceList();
    super.onInit();
  }

  Future<void> getServiceList() async {
    _apiToken = await _storage.readString('apiToken');

    try {
      serviceList.value =
          await _masterData.getServicesList(token: _apiToken ?? '');
    } catch (e) {
      e.printError();
    }
  }

  Future<void> getServiceTypeList() async {
    _apiToken = await _storage.readString('apiToken');

    try {
      serviceList.value = await _masterData.getTypeTestList(
          token: _apiToken ?? '', locationId: '');
    } catch (e) {
      e.printError();
    }
  }

  Future<void> getHistoryRowList() async {
    _apiToken = await _storage.readString('apiToken');

    try {
      transactions.value = ((await _historyRepository.getHistoryList(
                token: _apiToken ?? '',
              )) ??
              [])
          .map(
            (e) => Transaction(
              id: e.transactionId ?? "",
              type: e.services ?? "",
              date: e.testDate ?? "",
              price: double.parse(e.price ?? "00"),
              status: _statusConverter(e.statusText!),
            ),
          )
          .toList();
    } catch (e) {
      e.printError();
    }
  }

  TRANSACTIONSTATUS _statusConverter(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return TRANSACTIONSTATUS.newTransaction;
      case 'CANCEL':
        return TRANSACTIONSTATUS.canceled;
      case 'READY TO LAB':
        return TRANSACTIONSTATUS.readyToLab;
      case 'READY TO SAMPLE':
        return TRANSACTIONSTATUS.readyToSample;
      case 'PAYMENT REJECTED':
        return TRANSACTIONSTATUS.paymentRejected;
      case 'DONE':
        return TRANSACTIONSTATUS.done;
      case 'RESULT VERIFICATION':
        return TRANSACTIONSTATUS.resultVerification;
      case 'CONFIRMED':
        return TRANSACTIONSTATUS.confirmed;
      case 'PARTIALLY TO SAMPLE':
        return TRANSACTIONSTATUS.partiallyToSample;
      case 'PARTIALLY TO LAB':
        return TRANSACTIONSTATUS.partiallyToLab;
      case 'LAB PROCESS':
        return TRANSACTIONSTATUS.labProcess;
      case 'READY TO RELASE':
        return TRANSACTIONSTATUS.readyToRelease;
      case 'PARTIALLY DONE':
        return TRANSACTIONSTATUS.partiallyDone;
      default:
        return TRANSACTIONSTATUS.newTransaction;
    }
  }
}
