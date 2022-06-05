import 'dart:convert';
import 'dart:developer';

import 'package:kayabe_lims/app/core/utils/utils.dart';
import 'package:kayabe_lims/app/data/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:kayabe_lims/app/data/services/local_storage_service.dart';

class ArticleRepository {
  final String _baseUrl = "https://api-dl.konsultasi.in/v1/web";

  Future<List<ArticleModel>> getArticles(
    String search,
    int category,
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
              "category_id": category
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
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<ArticleDetailModel> getArticleDetail(
    int id,
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
        return ArticleDetailModel.fromJson(jsonDecode(value.body)['data']);
      });

      switch (responseStatus) {
        case "200":
          return _response;

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception(message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ArticleCommentModel>> getArticleComment(
    int articleId,
  ) async {
    final url = Uri.parse('$_baseUrl/content/article/comment');
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
          "max_rows": 1000,
          "order_by": "id",
          "order_type": "asc",
          "article_id": articleId
        }),
      )
          .then((value) {
        logger.e(value);
        return ArticleResponse.fromJson(jsonDecode(value.body));
      });

      logger.i(_response.data.toJson());

      switch (_response.status) {
        case "200":
          return _response.data.rows
              .map((e) => ArticleCommentModel.fromJson(e))
              .toList();

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception('$_response.message');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<bool> createArticleComment({
    required int articleId,
    required String comment,
    required String fullname,
  }) async {
    final storage = AppStorageService()..init();
    final token = await storage.readString('apiToken');

    final url = Uri.parse('$_baseUrl/content/article/comment-create');
    try {
      final _response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/content',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "article_id": articleId,
          "name": fullname,
          "comment": comment,
        }),
      );

      switch (_response.statusCode) {
        case 200:
          return true;

        case 401:
          return false;

        default:
          logger.e(_response.body);
          return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<List<ArticleCategoryModel>> getArticleCategories() async {
    final url = Uri.parse('$_baseUrl/content/article/category');

    try {
      late String responseStatus;
      late String message;
      final CategoryResponse _response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'fendpoint': '/content',
        },
      ).then((value) {
        responseStatus = jsonDecode(value.body)['status'];
        message = jsonDecode(value.body)['message'];
        logger.i(jsonDecode(value.body));
        return CategoryResponse.fromJson(jsonDecode(value.body));
      });

      switch (responseStatus) {
        case "200":
          return _response.data
              .map((e) => ArticleCategoryModel.fromJson(e))
              .toList();

        case "401":
          throw Exception('Authentication Failed');

        default:
          throw Exception(message);
      }
    } catch (e) {
      logger.e(e);
      throw Exception(e.toString());
    }
  }
}
