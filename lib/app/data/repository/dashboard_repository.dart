import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardRepository {
  final String baseUrl = "https://api-lims.kayabe.id/v1/web";

  Future<List<dynamic>> fetchArticleData({required String token}) async {
    var url = Uri.parse("$baseUrl/content/article");

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
