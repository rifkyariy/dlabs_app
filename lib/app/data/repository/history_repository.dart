import 'package:kayabe_lims/app/data/dtos/history_dto.dart';
import 'package:kayabe_lims/app/data/models/medical_history_model/medical_history_data.dart';
import 'package:kayabe_lims/app/data/models/medical_history_model/medical_history_model.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_data.dart';
import 'package:kayabe_lims/app/data/models/trx_detail_history_model/trx_detail_history_model.dart';
import 'package:kayabe_lims/app/data/models/trx_history_model/trx_history_model.dart';
import 'package:kayabe_lims/app/data/models/trx_history_model/trx_history_row.dart';
import 'package:http/http.dart' as http;

class HistoryRepository {
  final String _kbaseUrl = "https://api-dl.konsultasi.in/v1/web";

  Future<List<TrxHistoryRow>?> getHistoryList({
    required String token,
  }) async {
    final url = Uri.parse('$_kbaseUrl/history-trx/list');

    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/history-trx',
          'Authorization': 'Bearer $token',
        },
        body: const HistoryDto(
          maxRows: 9999999,
          orderBy: 'created_date',
          orderType: 'desc',
          page: 1,
          search: [SearchDto(value: '')],
        ).toJson(),
      );

      switch (_response.statusCode) {
        case 200:
          return (TrxHistoryModel.fromJson(_response.body)).data!.rows;

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

  Future<TrxDetailData?> getDetailHistory({
    required String token,
    required String idTransaction,
  }) async {
    final url = Uri.parse('$_kbaseUrl/history-trx/$idTransaction');

    try {
      final _response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/history-trx',
          'Authorization': 'Bearer $token',
        },
      );

      switch (_response.statusCode) {
        case 200:
          return (TrxDetailHistoryModel.fromJson(_response.body).data);

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

  Future<List<MedicalHistoryData>?> getMedicalHistory({
    required String token,
    required String transactionId,
    required String patientId,
  }) async {
    final url = Uri.parse('$_kbaseUrl/sample/history');

    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/sample',
          'Authorization': 'Bearer $token',
        },
        body: HistoryDto(
          maxRows: 9999999,
          orderBy: 'created_date',
          orderType: 'desc',
          page: 1,
          search: const [SearchDto(value: '')],
          patientId: int.parse(patientId),
          transactionId: transactionId,
        ).toJson(),
      );

      switch (_response.statusCode) {
        case 200:
          return (MedicalHistoryModel.fromJson(_response.body)).data!.rows;

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
