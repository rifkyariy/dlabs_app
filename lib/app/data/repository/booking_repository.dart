import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingRepository {
  final String baseUrl = "https://api-lims.kayabe.id/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<dynamic> createPersonalBooking(
      {required Map<String, dynamic> payload, required String token}) async {
    var url = Uri.parse("$baseUrl/transaction/private");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode(payload);
    final response = await http.post(url, headers: headers, body: body);

    var result;
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['data'];
    } else {
      final data = jsonDecode(response.body);
      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }

    return result;
  }

  Future<bool> createOrganizationBooking(
      {required Map<String, dynamic> payload, required String token}) async {
    var url = Uri.parse("$baseUrl/transaction/organization/create-transaction");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode(payload);
    final response = await http.post(url, headers: headers, body: body);

    bool result = false;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      result = true;
    } else {
      final data = jsonDecode(response.body);
      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }

    return result;
  }

  Future readPatient({required token, isAll}) async {
    var url = Uri.parse("$baseUrl/transaction/organization/read-patient");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    var rowsLength = isAll ? 1000 : 5;

    final payload = {
      "page": 1,
      "max_rows": rowsLength,
      "order_by": "created_date",
      "order_type": "asc",
      "search": [
        {"column": "name", "value": ""}
      ]
    };

    final body = jsonEncode(payload);
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      print(data);
      return data;
    } else {
      final data = jsonDecode(response.body);
      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }
  }

  Future updatePatient(
      {required Map<String, dynamic> payload, required token}) async {
    var url = Uri.parse("$baseUrl/transaction/organization/update-patient");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode(payload);

    final response = await http.post(url, headers: headers, body: body);

    bool result = false;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      result = true;
    } else {
      final data = jsonDecode(response.body);
      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }

    return result;
  }

  Future deletePatient(
      {required Map<String, dynamic> payload, required token}) async {
    var url = Uri.parse("$baseUrl/transaction/organization/delete-patient");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode(payload);

    final response = await http.post(url, headers: headers, body: body);

    bool result = false;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      result = true;
    } else {
      final data = jsonDecode(response.body);
      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }

    return result;
  }

  Future addPatient(
      {required Map<String, dynamic> payload, required token}) async {
    var url = Uri.parse("$baseUrl/transaction/organization/create-patient");

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/transaction',
      'Authorization': 'Bearer $token',
    };

    print(payload);

    final body = jsonEncode(payload);

    final response = await http.post(url, headers: headers, body: body);

    bool result = false;
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      result = true;
    } else {
      final data = jsonDecode(response.body);

      if (data.containsKey('status')) {
        String error = jsonDecode(response.body)['errors'];
        throw (error);
      } else {
        String error = jsonDecode(response.body)['message'];
        throw (error);
      }
    }

    return result;
  }
}
