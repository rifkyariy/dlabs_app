import 'dart:io';

import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';
import 'package:dlabs_apps/app/data/models/questionnaire_model/questionnaire_data_model.dart';
import 'package:dlabs_apps/app/data/models/transaction.dart';
import 'package:dlabs_apps/app/data/models/trx_detail_history_model/trx_detail_data.dart';
import 'package:dlabs_apps/app/data/repository/history_repository.dart';
import 'package:dlabs_apps/app/data/repository/master_data_repository.dart';
import 'package:dlabs_apps/app/data/repository/transaction_repository.dart';
import 'package:dlabs_apps/app/data/services/app_converter.dart';
import 'package:dlabs_apps/app/data/services/local_storage_service.dart';
import 'package:dlabs_apps/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:dlabs_apps/app/modules/transaction/views/medical_questionnarie_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/organization_transaction_detail/organization_transaction_detail_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/patient_list_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/payment/payment_offline.dart';
import 'package:dlabs_apps/app/modules/transaction/views/payment/payment_personal.dart';
import 'package:dlabs_apps/app/modules/transaction/views/personal_transaction_detail/personal_transaction_detail_view.dart';
import 'package:dlabs_apps/app/modules/transaction/views/personal_transaction_detail/personal_transaction_patient_information_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionViewController extends GetxController {
  final AppStorageService _storage = Get.find();
  final MasterDataRepository _master = Get.find();
  final HistoryRepository _historyRepository = Get.find();
  final TransactionRepository _transactionRepository = Get.find();

  /// Current Transaction status.
  /// It will changes when user tap the History Card
  ///
  TRANSACTIONSTATUS currentTransactionStatus = TRANSACTIONSTATUS.newTransaction;

  /// This is the list that holds the transcations
  /// This list is displayed on history screen.
  ///
  RxList<Transaction> transactionHistory = <Transaction>[].obs;

  /// This is the list that holds the medical questionnaire from backend
  /// This list is displayed on transaction/patient-detail screen, and also
  /// Medical questionnaire screen
  List<QuestionnaireDataModel>? medicalQuestionnaireList =
      <QuestionnaireDataModel>[].obs;

  /// This is the Transaction Detail Information
  /// It holds for both personal and organization booking
  ///
  late TrxDetailData transactionDetail;
  late TextEditingController selectedPaymentMethod =
      TextEditingController(text: '1');
  late RxString selectedPaymentMethodName = "".obs;
  late RxString selectedAccountHolder = "".obs;
  late RxString selectedAccountNumber = "".obs;

  /// State
  /// This is the state of the screen
  ///
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    updateHistoryRowList(enableLoadingEffect: true);

    await getOfflinePaymentMethod().then((result) {
      paymentMethodList!.value = result.toList();

      var filteredList = paymentMethodList!.where((listItem) =>
          listItem['id'] == selectedPaymentMethod.text.toString());

      selectedPaymentMethodName.value =
          filteredList.toList().elementAt(0)['payment_name'];
      selectedAccountHolder.value =
          filteredList.toList().elementAt(0)['acc_holder_name'];
      selectedAccountNumber.value =
          filteredList.toList().elementAt(0)['acc_number'];
    });

    super.onInit();
  }

  /// This will update the [transactionHistory] list
  /// If [enableLoadingEffect] is set to enable, then when this method being called
  /// [isLoading] will have true value on first method call.
  Future<void> updateHistoryRowList({bool? enableLoadingEffect}) async {
    final _apiToken = await _storage.readString('apiToken');

    try {
      isLoading.value = enableLoadingEffect ?? false;

      transactionHistory.value =
          ((await _historyRepository.getHistoryList(token: _apiToken ?? '')) ??
                  [])
              // Map TRXHistoryRow Model to Transaction
              .map(
        (t) {
          return Transaction(
            id: t.transactionId ?? "",
            type: t.services ?? "",
            date: t.testDate ?? "",
            price: double.parse(t.price ?? "00"),
            status: AppConverter.transactionStatusToEnum(t.statusText!),
          );
        },
      ).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      e.printError();
    }
  }

  Future<void> updateMedicalQuestionnaireList(String transactionId) async {
    final _apiToken = await _storage.readString('apiToken');

    try {
      medicalQuestionnaireList =
          await _transactionRepository.getDetailQuestionaireList(
        token: _apiToken ?? '',
        transactionId: transactionId,
      );
    } catch (e) {
      e.printError();
    }
  }

  /// This will return [TrxDetailData] object
  /// [TrxDetailData] is object that holds Transaction Detail
  /// All Information in Transaction Detail live in [TrxDetailData]
  Future<TrxDetailData> getDetailTransaction(String transactionId) async {
    final _apiToken = await _storage.readString('apiToken');

    try {
      final _trxDetailData = await _historyRepository.getDetailHistory(
            token: _apiToken ?? '',
            idTransaction: transactionId,
          ) ??
          const TrxDetailData();

      return _trxDetailData;
    } catch (e) {
      e.printError();
      throw Exception(e);
    }
  }

  /// Handle Tap on Transaction History CARD
  /// Will update [transactionDetail] based on [transactionId]
  /// Will update [currentTransactionStatus] based on [status]
  Future<void> onTransactionCardPressed({
    required String transactionId,
    required TRANSACTIONSTATUS status,
  }) async {
    try {
      // Set current Transaction Type to the one that user clicked
      currentTransactionStatus = status;

      // Show Loading Overlay
      // Load detail transaction
      await Get.showOverlay(
        asyncFunction: () async {
          transactionDetail = await getDetailTransaction(transactionId);

          // If Transaction not new and not organization
          if ((transactionDetail.isPrivate ?? '1') == '1') {
            await updateMedicalQuestionnaireList(transactionId);
          }
        },
        loadingWidget: const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );

      // Go to payment screen if [status] is NEW Transaction
      //
      if (status == TRANSACTIONSTATUS.newTransaction &&
          (transactionDetail.isPrivate ?? '1') == '1') {
        toPaymentScreen(TRANSACTIONTYPE.personal);
      }

      if (status == TRANSACTIONSTATUS.newTransaction &&
          (transactionDetail.isPrivate ?? '1') != '1') {
        toPaymentScreen(TRANSACTIONTYPE.organization);
      }

      // If [transactionDetail.isPrivate] is 1 then go to Personal Page
      //  TRANSACTIONTYPE.personal
      if (status != TRANSACTIONSTATUS.newTransaction &&
          (transactionDetail.isPrivate ?? '1') == '1') {
        toDetailTransactionScreen(TRANSACTIONTYPE.personal);
      }

      // If [transactionDetail.isPrivate] is not 1 then go to Organization Page
      // TRANSACTIONTYPE.organization
      if (status != TRANSACTIONSTATUS.newTransaction &&
          (transactionDetail.isPrivate ?? '1') != '1') {
        toDetailTransactionScreen(TRANSACTIONTYPE.organization);
      }
    } catch (e) {
      e.printError();
    }
  }

  /// Go to payment screen
  void toPaymentScreen(TRANSACTIONTYPE transactiontype) {
    if (transactiontype == TRANSACTIONTYPE.personal) {
      Get.to(
        () => const PersonalPaymentView(),
        binding: TransactionHistoryViewBinding(),
      );
    } else {
      Get.to(
        () => const OrganizationTransactionDetailView(),
        binding: TransactionHistoryViewBinding(),
      );
    }
  }

  /// Go to the different screen based on [transactiontype]
  void toDetailTransactionScreen(TRANSACTIONTYPE transactiontype) {
    if (TRANSACTIONTYPE.personal == transactiontype) {
      Get.to(
        () => const PersonalTransactionDetailView(),
        binding: TransactionHistoryViewBinding(),
      );
    } else {
      Get.to(
        () => const OrganizationTransactionDetailView(),
        binding: TransactionHistoryViewBinding(),
      );
    }
  }

  void toPatientListScreen() {
    Get.to(() => const TransactionPatientListView());
  }

  void toPatientDetailScrenn() {
    Get.to(() => const PersonalTransactionPatientInformationView());
  }

  void toMedicalQuestionnaireListView() {
    Get.to(() => const MedicalQuestionnarieView());
  }

  void toOfflinePayment() {
    Get.to(
      () => const PaymentOfflineView(),
      binding: TransactionHistoryViewBinding(),
    );
  }

  RxList<Map<String, dynamic>>? paymentMethodList =
      <Map<String, dynamic>>[].obs;

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

  Future<List<Map<String, dynamic>>> getOfflinePaymentMethod() async {
    final _apiToken = await _storage.readString('apiToken');
    var result = await await _master.getOfflinePaymentMethod(token: _apiToken!);
    var apiServiceKey = ["id", "payment_name"];

    return convertIntoList(apiServiceKey, result);
  }

  late RxString? uploadedFilename = ''.obs;

  Future<void> getLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );

    if (result != null) {
      // File file = File(result.files.single.path!);
      PlatformFile file = result.files.first;
      uploadedFilename!.value = file.name;
      print(file.name);
    } else {
      // User canceled the picker
    }
  }
}
