import 'dart:convert';
import 'package:http/http.dart' as http;

class MasterDataRepository {
  final String baseUrl = "https://api-lims.kayabe.id/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future getLocationList({required String token}) async {
    var url = Uri.parse("$baseUrl/master/location");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/master',
      'Authorization': 'Bearer $token',
    });

    var locationList = (jsonDecode(response.body)["data"]["list"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return locationList;
  }

  Future getTypeTestList(
      {required String token, required String locationId}) async {
    var url = Uri.parse("$baseUrl/master/location/$locationId");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/master',
      'Authorization': 'Bearer $token',
    });

    var locationList =
        (jsonDecode(response.body)["data"]["test_type_list"] as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();

    return locationList;
  }

  Future getServicesList({required String token}) async {
    var url = Uri.parse("$baseUrl/master/services");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/master',
      'Authorization': 'Bearer $token',
    });

    var locationList = (jsonDecode(response.body)["data"]["list"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return locationList;
  }
}
