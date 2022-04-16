import 'dart:convert';

import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  final String _baseUrl = "https://api-dl.konsultasi.in/v1/web";

  Future<List<ArticleModel>> getArticles(
    String search,
  ) async {
    final url = Uri.parse('$_baseUrl/transaction/private/kuesioner');
    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/content',
        },
        body: jsonEncode({
          "page": 1,
          "max_rows": 100,
          "order_by": "id",
          "order_type": "asc",
          "search": [
            {"value": search}
          ],
          "category_id": 1
        }),
      );

      final responseData = ArticleResponse.fromJson(jsonDecode(_response.body));

      switch (_response.statusCode) {
        case 200:
          return responseData.data['rows']
              .map((e) => ArticleModel.fromJson(e))
              .toList();

        case 401:
          throw Exception('Authentication Failed');

        default:
          throw Exception('${_response.statusCode} ${_response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
