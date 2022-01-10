import 'package:kayabe_lims/app/data/enums/transaction_enum.dart';
import 'package:kayabe_lims/app/data/models/patient_model.dart';

class Transaction {
  final String id;
  final String type;
  final String date;
  final double price;
  final TRANSACTIONSTATUS status;
  final PatientModel? patient;

  Transaction({
    required this.id,
    required this.type,
    required this.date,
    required this.price,
    required this.status,
    this.patient,
  });
}
