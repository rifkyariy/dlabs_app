import 'package:dlabs_apps/app/data/enums/transaction_enum.dart';

class AppConverter {
  static TRANSACTIONSTATUS transactionStatusToEnum(String status) {
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
      case 'READY TO RELEASE':
        return TRANSACTIONSTATUS.readyToRelease;
      case 'PARTIALLY DONE':
        return TRANSACTIONSTATUS.partiallyDone;
      case 'PAYMENT':
        return TRANSACTIONSTATUS.payment;
      default:
        return TRANSACTIONSTATUS.newTransaction;
    }
  }

  static String transactionEnumToString(TRANSACTIONSTATUS status) {
    switch (status) {
      case TRANSACTIONSTATUS.newTransaction:
        return "New";
      case TRANSACTIONSTATUS.confirmed:
        return "Confirmed";
      case TRANSACTIONSTATUS.inProgress:
        return "In Progress";
      case TRANSACTIONSTATUS.readyToLab:
        return "Ready to Lab";
      case TRANSACTIONSTATUS.resultVerification:
        return "Result Verification";
      case TRANSACTIONSTATUS.canceled:
        return "Canceled";
      case TRANSACTIONSTATUS.done:
        return "Done";
      case TRANSACTIONSTATUS.readyToSample:
        return "Ready to Sample";
      case TRANSACTIONSTATUS.paymentRejected:
        return "Payment Rejected";
      case TRANSACTIONSTATUS.partiallyToSample:
        return "Partially to Sample";
      case TRANSACTIONSTATUS.partiallyToLab:
        return "Partially to Lab";
      case TRANSACTIONSTATUS.labProcess:
        return "Lab Process";
      case TRANSACTIONSTATUS.readyToRelease:
        return "Ready to Release";
      case TRANSACTIONSTATUS.partiallyDone:
        return "Partially Done";
      case TRANSACTIONSTATUS.payment:
        return "Payment";
    }
  }
}
