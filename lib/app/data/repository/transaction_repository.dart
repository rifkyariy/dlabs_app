import 'dart:convert';

import 'package:dlabs_apps/app/modules/personal_booking/views/questionnaire.dart';
import 'package:http/http.dart' as http;

class TransactionRepository {
  final String _kbaseUrl = "https://api-lims.kayabe.id/v1/web";

  Future<List<Questionnaire>?> getDetailQuestionaireList({
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
          return (jsonDecode(_response.body)['data']);

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
