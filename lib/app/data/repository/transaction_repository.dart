import 'dart:convert';

import 'package:dlabs_apps/app/data/models/invoice_model/invoice_data.dart';
import 'package:dlabs_apps/app/data/models/invoice_model/invoice_model.dart';
import 'package:dlabs_apps/app/data/models/payment_proof_model.dart';
import 'package:dlabs_apps/app/data/models/questionnaire_model/questionnaire_data_model.dart';
import 'package:dlabs_apps/app/data/models/questionnaire_model/questionnaire_model.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  final String _kbaseUrl = "https://api-lims.kayabe.id/v1/web";

  Future<List<QuestionnaireDataModel>?> getDetailQuestionaireList({
    required String token,
    required String transactionId,
  }) async {
    final url = Uri.parse('$_kbaseUrl/transaction/private/kuesioner');

    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/transaction',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"transaction_id": transactionId}),
      );

      switch (_response.statusCode) {
        case 200:
          return (QuestionnaireModel.fromJson(_response.body)).data;

        case 401:
          throw Exception('Authentication Failed');

        case 500:
          throw Exception('Internal Server Error');

        default:
          throw Exception('${_response.statusCode} ${_response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<InvoiceData?> getInvoiceData({
    required String idTransaction,
    required String token,
  }) async {
    final url =
        Uri.parse('$_kbaseUrl/transaction/private/print/$idTransaction');
    try {
      final _response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/transaction',
          'Authorization': 'Bearer $token',
        },
      );

      switch (_response.statusCode) {
        case 200:
          return (InvoiceModel.fromJson(_response.body)).data;

        case 401:
          throw Exception('Authentication Failed');

        case 500:
          throw Exception('Internal Server Error');

        default:
          throw Exception('${_response.statusCode} ${_response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaymentProofModel?> getPaymentProof({
    required String token,
    required String transactionId,
  }) async {
    final url = Uri.parse('$_kbaseUrl/payment/proof');

    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/transaction',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"transaction_no": transactionId}),
      );

      switch (_response.statusCode) {
        case 200:
          return (PaymentProofModel.fromJson(_response.body));

        case 401:
          throw Exception('Authentication Failed');

        case 500:
          throw Exception('Internal Server Error');

        default:
          throw Exception('${_response.statusCode} ${_response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
