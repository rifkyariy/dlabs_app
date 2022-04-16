import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kayabe_lims/app/core/theme/app_theme.dart';
import 'package:kayabe_lims/app/data/models/invoice_model/invoice_data.dart';
import 'package:kayabe_lims/app/data/models/invoice_model/invoice_model.dart';
import 'package:kayabe_lims/app/data/models/payment_proof_model.dart';
import 'package:kayabe_lims/app/data/models/questionnaire_model/questionnaire_data_model.dart';
import 'package:kayabe_lims/app/data/models/questionnaire_model/questionnaire_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;

class TransactionRepository {
  final String _kbaseUrl = "https://api-dl.konsultasi.in/v1/web";

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
          String errors = jsonDecode(_response.body)['errors'];

          if (errors.toLowerCase().contains('questionare')) {
            return (QuestionnaireModel.fromJson(_response.body)).data;
          } else {
            throw Exception('Internal Server Error');
          }

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
          final bool cashMethod =
              jsonDecode(_response.body)['errors'].toString() ==
                  "File Payment not Uploaded yet";

          if (cashMethod) {
            getx.Get.snackbar(
              'Info',
              'Please come to the cashier and pay with cash or debit.',
              backgroundColor: primaryColor,
              colorText: whiteColor,
              snackPosition: getx.SnackPosition.TOP,
            );

            throw Exception('Internal Server Error');
          } else {
            throw Exception('Internal Server Error');
          }

        default:
          throw Exception('${_response.statusCode} ${_response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaymentProofModel?> cancelTransaction({
    required String token,
    required String transactionId,
  }) async {
    final url = Uri.parse('$_kbaseUrl/payment/cancel');

    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/payment',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "transaction_no": transactionId,
          "status": "9",
        }),
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

  Future<void> uploadPaymentProof({
    required String path,
    required String token,
    required String transactionId,
  }) async {
    final _dio = Dio();

    try {
      final String _fileName = path.split('/').last;
      Map<String, dynamic> _fileMap;
      if (_fileName != "") {
        _fileMap = {
          "file": await MultipartFile.fromFile(
            path,
            filename: _fileName,
          ),
          "transaction_no": transactionId,
        };
      } else {
        _fileMap = {
          "transaction_no": transactionId,
        };
      }

      FormData formData = FormData.fromMap(_fileMap);
      await _dio.post(
        '$_kbaseUrl/payment/upload',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data;',
            'fendpoint': '/payment',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
