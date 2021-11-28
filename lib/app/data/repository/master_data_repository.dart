import 'dart:convert';
import 'package:dlabs_apps/app/data/models/location_model.dart';
import 'package:http/http.dart' as http;

class MasterDataRepository {
  final String BaseUrl = "https://devapi-dl.konsultasi.in/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<List<dynamic>> getLocationList({required String token}) async {
    var url = Uri.parse("$BaseUrl/master/location");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/master',
      'Authorization': 'Bearer $token',
    });

    var locationList = jsonDecode(response.body)['data']['list'];
    List<dynamic> result = locationList;

    return result;
  }
}
