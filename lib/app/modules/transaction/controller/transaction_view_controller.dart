import 'dart:io';

import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/payment_proof_model.dart';
import 'package:kayabe_lims/app/data/models/transaction.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_patient_list.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_tracking_list.dart';
import 'package:kayabe_lims/app/data/services/app_converter.dart';
import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/repository/history_repository.dart';
import 'package:kayabe_lims/app/data/models/invoice_model/invoice_data.dart';
import 'package:kayabe_lims/app/data/models/medical_history_model/medical_history_data.dart';
import 'package:kayabe_lims/app/data/models/questionnaire_model/questionnaire_data_model.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_data.dart';
import 'package:kayabe_lims/app/data/repository/master_data_repository.dart';
import 'package:kayabe_lims/app/data/repository/transaction_repository.dart';
import 'package:kayabe_lims/app/data/services/file_downloader.dart';
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';
import 'package:kayabe_lims/app/modules/transaction/bindings/transaction_history_binding.dart';
import 'package:kayabe_lims/app/modules/transaction/views/invoice_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/medical_history_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/medical_questionnarie_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/organization_transaction_detail/organization_transaction_detail_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/organization_transaction_detail/organization_transaction_patient_information_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/patient_list_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/organization_payment_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/payment_cash.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/personal_payment_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/payment/payment_offline.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/personal_transaction_detail_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/personal_transaction_patient_information_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/personal_transaction_detail/transaction_history/transaction_history_view.dart';
import 'package:kayabe_lims/app/modules/transaction/views/tracking/tracking_process_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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

  /// This is the list that holds the medical history from backend
  /// This list is displayed on transaction/medical history screen
  List<MedicalHistoryData>? medicalHistoryList = <MedicalHistoryData>[];

  /// This is the Transaction Detail Information
  /// It holds for both personal and organization booking
  ///
  late TrxDetailData transactionDetail;

  TextEditingController selectedPaymentMethod =
      TextEditingController(text: '1');

  RxString selectedPaymentMethodName = "".obs;
  RxString selectedAccountHolder = "".obs;
  RxString selectedAccountNumber = "".obs;

  /// This is the Invoice Detail Information
  /// It holds for the transaction invoice on specific transaction ID
  late InvoiceData invoiceData;

  /// State
  /// This is the state of the screen
  ///
  RxBool isLoading = false.obs;

  late String paymentProofLocation = "";

  @override
  void onInit() async {
    updateHistoryRowList(enableLoadingEffect: true);

    _getOfflinePayment();
    selectedPaymentMethod.addListener(_getOfflinePayment);

    super.onInit();
  }

  void _getOfflinePayment() async {
    await getOfflinePaymentMethod().then((result) {
      paymentMethodList!.value = result.toList();

      var filteredList = paymentMethodList!.where((listItem) =>
          listItem['id'] == selectedPaymentMethod.text.toString());

      print(filteredList.toList().elementAt(0)['payment_name'].toString());

      selectedPaymentMethodName.value =
          filteredList.toList().elementAt(0)['payment_name'];
      selectedAccountHolder.value =
          filteredList.toList().elementAt(0)['acc_holder_name'];
      selectedAccountNumber.value =
          filteredList.toList().elementAt(0)['acc_number'];
    });
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
      throw Exception(e);
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
      throw Exception(e);
    }
  }

  Future<void> updateMedicalHistoryList({
    required String transactionId,
    required String patientId,
  }) async {
    final _apiToken = await _storage.readString('apiToken');

    try {
      medicalHistoryList = await _historyRepository.getMedicalHistory(
        token: _apiToken ?? '',
        transactionId: transactionId,
        patientId: patientId,
      );
    } catch (e) {
      throw Exception(e);
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

  /// This will return [InvoiceData] object
  /// [InvoiceData] is object that holds Invoice Data
  /// All Information in Invoice Data live in [InvoiceData]
  Future<InvoiceData> getInvoiceData(String transactionId) async {
    final _apiToken = await _storage.readString('apiToken');
    try {
      final _invoiceData = await _transactionRepository.getInvoiceData(
            token: _apiToken ?? '',
            idTransaction: transactionId,
          ) ??
          const InvoiceData();
      return _invoiceData;
    } catch (e) {
      e.printError();
      throw Exception(e);
    }
  }

  /// Update History List
  refreshHistoryList() {
    transactionHistory.refresh();
    updateHistoryRowList(enableLoadingEffect: false);
  }

  Future<String> getPaymentProof(String transactionId) async {
    final _apiToken = await _storage.readString('apiToken') ?? '';
    final _paymentProofUrl = await _transactionRepository.getPaymentProof(
        token: _apiToken, transactionId: transactionId);
    return (_paymentProofUrl ?? const PaymentProofModel()).data ?? '';
  }

  Future cancelTransaction(String transactionId) async {
    final _apiToken = await _storage.readString('apiToken') ?? '';
    try {
      await _transactionRepository.cancelTransaction(
          token: _apiToken, transactionId: transactionId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future uploadPaymentProof({
    required String path,
    required String transactionId,
  }) async {
    final _apiToken = await _storage.readString('apiToken') ?? '';
    try {
      await _transactionRepository.uploadPaymentProof(
        path: path,
        token: _apiToken,
        transactionId: transactionId,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  /// TODO kasih komen

  Future<void> onInvoiceButtonPressed(String transactionId) async {
    await Get.showOverlay(
      asyncFunction: () async {
        invoiceData = await getInvoiceData(transactionId);
      },
      loadingWidget: const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      ),
    );
    toInvoiceView();
  }

  /// Handle Tap on Transaction History CARD
  /// Will update [transactionDetail] based on [transactionId]
  /// Will update [currentTransactionStatus] based on [status]
  Future<void> onTransactionCardPressed({
    required String transactionId,
    required TRANSACTIONSTATUS status,
    bool isDestroyState = false,
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
            await updateMedicalHistoryList(
              transactionId: transactionId,
              patientId:
                  '${(transactionDetail.patientList ?? <TrxDetailPatientList>[]).first.id}',
            );
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
      if (status == TRANSACTIONSTATUS.newTransaction ||
          status == TRANSACTIONSTATUS.paymentRejected) {
        if ((transactionDetail.isPrivate ?? '1') == '1') {
          toPaymentScreen(TRANSACTIONTYPE.personal, isDestroyState);
        }
      }

      if (status == TRANSACTIONSTATUS.newTransaction ||
          status == TRANSACTIONSTATUS.paymentRejected) {
        if ((transactionDetail.isPrivate ?? '1') != '1') {
          toPaymentScreen(TRANSACTIONTYPE.organization, isDestroyState);
        }
      }

      // If [transactionDetail.isPrivate] is 1 then go to Personal Page
      //  TRANSACTIONTYPE.personal
      if (status != TRANSACTIONSTATUS.newTransaction &&
          status != TRANSACTIONSTATUS.paymentRejected &&
          (transactionDetail.isPrivate ?? '1') == '1') {
        toDetailTransactionScreen(TRANSACTIONTYPE.personal, isDestroyState);
      }

      // If [transactionDetail.isPrivate] is not 1 then go to Organization Page
      // TRANSACTIONTYPE.organization
      if (status != TRANSACTIONSTATUS.newTransaction &&
          status != TRANSACTIONSTATUS.paymentRejected &&
          (transactionDetail.isPrivate ?? '1') != '1') {
        toDetailTransactionScreen(TRANSACTIONTYPE.organization, isDestroyState);
      }
    } catch (e) {
      e.printError();
    }
  }

  /// Go to payment screen
  toPaymentScreen(TRANSACTIONTYPE transactiontype, bool isDestroyState) {
    if (isDestroyState) {
      if (transactiontype == TRANSACTIONTYPE.personal) {
        Get.off(
          () => const PersonalPaymentView(),
          binding: TransactionHistoryViewBinding(),
        );
      } else {
        Get.off(
          () => const OrganizationPaymentView(),
          binding: TransactionHistoryViewBinding(),
        );
      }
    } else {
      if (transactiontype == TRANSACTIONTYPE.personal) {
        Get.to(
          () => const PersonalPaymentView(),
          binding: TransactionHistoryViewBinding(),
        );
      } else {
        Get.to(
          () => const OrganizationPaymentView(),
          binding: TransactionHistoryViewBinding(),
        );
      }
    }
  }

  /// Go to the different screen based on [transactiontype]
  toDetailTransactionScreen(
      TRANSACTIONTYPE transactiontype, bool isDestroyState) {
    if (isDestroyState) {
      if (TRANSACTIONTYPE.personal == transactiontype) {
        Get.off(
          () => const PersonalTransactionDetailView(),
          binding: TransactionHistoryViewBinding(),
        );
      } else {
        Get.off(
          () => const OrganizationTransactionDetailView(),
          binding: TransactionHistoryViewBinding(),
        );
      }
    } else {
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
  }

  toPatientListScreen() {
    Get.to(() => const TransactionPatientListView());
  }

  toPatientDetailScrenn() {
    Get.to(() => const PersonalTransactionPatientInformationView());
  }

  toOrgPatientDetailScrenn() {
    Get.to(() => const OrganizationTransactionPatientInformationView());
  }

  toMedicalQuestionnaireListView() {
    Get.to(() => const MedicalQuestionnarieView());
  }

  toMedicalHistoryListView() {
    Get.to(() => const MedicalHistoryView());
  }

  toInvoiceView() {
    Get.to(() => const InvoiceView(), binding: TransactionHistoryViewBinding());
  }

  onOfflineDialogButtonPressed() {}

  onOnlineDialogButtonPressed() {}

  onViewDetailButtonPressed(int index) async {
    try {
      await Get.showOverlay(
        asyncFunction: () async {
          await updateMedicalHistoryList(
            transactionId: transactionDetail.transactionId ?? '',
            patientId:
                (transactionDetail.patientList ?? [])[index].id.toString(),
          );
        },
        loadingWidget: const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );
      // toMedicalHistoryListView();
      toOrgPatientDetailScrenn();
    } catch (e) {
      Get.snackbar(
        'Error!',
        'Something went wrong!',
        backgroundColor: warningColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  onDownloadPaymentProofButtonPressed(String transactionId) async {
    final _url = await getPaymentProof(transactionId);
    Get.showOverlay(
      asyncFunction: () async {
        await _downloadFile(
          '${dotenv.env['BASE_URL']}$_url',
          _url.split('/').last,
        );
      },
      loadingWidget: Center(
        child: Card(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 20),
                Text("Downloading")
              ],
            ),
          ),
        ),
      ),
    );
  }

  onCancelTransactionButtonPressed(String transactionId) async {
    try {
      await Get.showOverlay(
        asyncFunction: () async {
          await cancelTransaction(transactionId);
        },
        loadingWidget: const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      );

      // Redirect to transaction history
      Get.off(
        () => const TransactionHistoryView(),
        binding: TransactionHistoryViewBinding(),
      );

      Get.snackbar(
        'Transaction Cancelled',
        'Transaction cancelled successfully',
        backgroundColor: greenSuccessColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error!',
        'Something went wrong!',
        backgroundColor: warningColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void check(args) {}

  onUploadPaymentProofPressed({
    required String path,
    required String transactionId,
  }) async {
    // Check if user already select file
    print(uploadedFilename);
    if (uploadedFilename!.value != "") {
      Get.showOverlay(
        asyncFunction: () async {
          await uploadPaymentProof(path: path, transactionId: transactionId);
        },
        loadingWidget: Center(
          child: Card(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 20),
                  Text("Uploading")
                ],
              ),
            ),
          ),
        ),
      );

      Get.snackbar(
        'Upload Successfull',
        'Proof of Payment  uploaded !',
        backgroundColor: greenSuccessColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );

      refreshHistoryList();

      // Refresh History List
      Get.back();
      Get.back();

      Future.delayed(const Duration(milliseconds: 500), () {
        refreshHistoryList();
      });
    } else {
      Get.snackbar(
        'Invalid File',
        'Please choose valid proof of payment',
        backgroundColor: primaryColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  onDownloadButtonPressed(String url) async {
    Get.showOverlay(
      asyncFunction: () async {
        await _downloadFile(
          url,
          url.split('/').last,
        );
      },
      loadingWidget: Center(
        child: Card(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 20),
                Text("Downloading")
              ],
            ),
          ),
        ),
      ),
    );
  }

  _downloadFile(
    String url,
    String fileName,
  ) async {
    Directory _path = await getExternalStorageDirectory() ??
        await getApplicationDocumentsDirectory();

    try {
      await FileDownloader.downloadFile(
        url: url,
        path: '${_path.path}/$fileName',
      );

      Get.snackbar(
        'Download Completed - Click to view!',
        'File saved to application directory',
        backgroundColor: greenSuccessColor,
        colorText: whiteColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        onTap: (value) {
          OpenFile.open('${_path.path}/$fileName');
        },
      );
    } catch (e) {
      e.toString() == 'file-already-exist'
          ? Get.snackbar(
              'File Already Exist - Click to view!',
              'File saved to application directory',
              backgroundColor: greenSuccessColor,
              colorText: whiteColor,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              onTap: (value) {
                OpenFile.open('${_path.path}/$fileName');
              },
            )
          : Get.snackbar(
              'Error!',
              'Something went wrong!',
              backgroundColor: warningColor,
              colorText: whiteColor,
              snackPosition: SnackPosition.TOP,
            );
    }
  }

  toTrackingProcessView() {
    Get.to(
      () => TrackingProcessView(
        processIndex: _getProgressIndex(),
      ),
      binding: TransactionHistoryViewBinding(),
    );
  }

  int _getProgressIndex() {
    final TrxDetailTrackingList _data =
        (transactionDetail.trackingList ?? []).first;

    final TRANSACTIONSTATUS _status = AppConverter.transactionStatusToEnum(
      (_data.status ?? '').toUpperCase(),
    );

    switch (_status) {
      case TRANSACTIONSTATUS.paymentRejected:
        return 0;

      case TRANSACTIONSTATUS.newTransaction:
        return -1;

      case TRANSACTIONSTATUS.payment:
        return 0;

      case TRANSACTIONSTATUS.confirmed:
        return 0;

      case TRANSACTIONSTATUS.readyToSample:
        return 0;

      case TRANSACTIONSTATUS.readyToLab:
        return 1;

      case TRANSACTIONSTATUS.resultVerification:
        return 2;

      case TRANSACTIONSTATUS.done:
        return 3;

      default:
        return -1;
    }
  }

  bool isHomeService() => (transactionDetail.services ?? '') == 'Home Service';

  void toOfflinePayment() {
    Get.to(
      () => const PaymentOfflineView(),
      binding: TransactionHistoryViewBinding(),
    );
  }

  void toCashPayment() {
    Get.to(
      () => const PaymentCashView(),
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

  Future<String> getLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      uploadedFilename!.value = file.name;

      paymentProofLocation = File(result.files.single.path!).path;
      return File(result.files.single.path!).path;
    } else {
      return '';
      // User canceled the picker
    }
  }
}
