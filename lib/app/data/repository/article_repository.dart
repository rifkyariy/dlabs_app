import 'dart:convert';
import 'dart:developer';

import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  final String _baseUrl = "https://api-dl.konsultasi.in/v1/web";

  Future<List<ArticleModel>> getArticles(
    String search,
  ) async {
    final url = Uri.parse('$_baseUrl/content/article');
    try {
      final ArticleResponse _response = await http
          .post(
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
          )
          .then((value) => ArticleResponse.fromJson(jsonDecode(value.body)));

      switch (_response.status) {
        case "200":
          return _response.data.rows
              .map((e) => ArticleModel.fromJson(e))
              .toList();

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception('$_response.message');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ArticleDetailModel> getArticleDetail(
    String id,
  ) async {
    final url = Uri.parse('$_baseUrl/content/article/$id');
    try {
      late String responseStatus;
      late String message;
      final ArticleDetailModel _response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/content',
        },
      ).then((value) {
        responseStatus = jsonDecode(value.body)['status'];
        message = jsonDecode(value.body)['message'];

        print(jsonDecode(value.body)['data']);
        return ArticleDetailModel.fromJson(jsonDecode(value.body)['data']);
      });

      switch (responseStatus) {
        case "200":
          return _response;

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception('$message');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
