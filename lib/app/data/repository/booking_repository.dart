import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingRepository {
  final String baseUrl = "https://api-lims.kayabe.id/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<bool> createPersonalBooking(
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
}
