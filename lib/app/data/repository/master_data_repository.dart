import 'dart:convert';
import 'package:http/http.dart' as http;

class MasterDataRepository {
  final String base = "https://api-lims.kayabe.id/";
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

  Future getQuestionnaire(
      {required String token, required String testTypeId}) async {
    var url = Uri.parse("$baseUrl/master/kuesioner/$testTypeId");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/master',
      'Authorization': 'Bearer $token',
    });

    var questionList = (jsonDecode(response.body)["data"]["list"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return questionList;
  }

  Future getTestPurposeList({required String token}) async {
    var url = Uri.parse("$baseUrl/test-purpose/list");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var purposeList = (jsonDecode(response.body)["data"]["list"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return purposeList;
  }

  Future getCompanyData({required String token}) async {
    var url = Uri.parse("$baseUrl/setting/company");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var result = (jsonDecode(response.body)["data"]);
    result['image'] = "${base}${result['image']}";

    return result;
  }
}
