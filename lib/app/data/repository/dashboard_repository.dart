import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardRepository {
  final String baseUrl = "https://api-dl.konsultasi.in/v1/web";

  Future<List<dynamic>> fetchBannerData({required String token}) async {
    var url = Uri.parse("$baseUrl/content/banner?status=publish");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'fendpoint': '/content',
        'Authorization': 'Bearer $token',
      },
    );

    var result = (jsonDecode(response.body)["data"] as List);

    return result;
  }

  Future<List<dynamic>> fetchArticleData({required String token}) async {
    var url = Uri.parse("$baseUrl/content/article");

    var payload = {
      "page": 1,
      "max_rows": 6,
      "order_by": "created_date",
      "order_type": "desc",
      "search": [
        {"value": ""}
      ]
    };

    final body = jsonEncode(payload);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'fendpoint': '/content',
          'Authorization': 'Bearer $token',
        },
        body: body);

    var result = (jsonDecode(response.body)["data"]["rows"] as List);

    return result;
  }

  Future<List<dynamic>> fetchServiceData({required String token}) async {
    var url = Uri.parse("$baseUrl/content/service");

    var payload = {
      "page": 1,
      "max_rows": 6,
      "order_by": "id",
      "order_type": "asc",
      "search": [
        {"value": ""}
      ]
    };

    final body = jsonEncode(payload);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'fendpoint': '/content',
          'Authorization': 'Bearer $token',
        },
        body: body);

    var result = (jsonDecode(response.body)["data"]["rows"] as List);

    return result;
  }
}
