import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dlabs_apps/app/data/models/user_model.dart';

class AuthService {
  final String BaseUrl = "https://devapi-dl.konsultasi.in/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("$BaseUrl/auth/login");
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': basicAuthenticationHeader(email, password)
    };
    var body = jsonEncode({'email': email, 'password': password});

    var response = await http.get(url, headers: headers);

    print(response);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return getUserData(token: data['token']);
    } else {
      throw ('Tidak Dapat Login');
    }
  }

  Future<UserModel> getUserData({required String token}) async {
    var url = Uri.parse("$BaseUrl/profile/me");

    print(token);
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/profile',
      'Authorization': 'Bearer $token',
    });

    var userData = jsonDecode(response.body)['data'];
    print(userData.containsKey('image'));

    UserModel user = UserModel.fromJson(userData);

    user.image = userData.containsKey('image')
        ? "https://devapi-dl.konsultasi.in/" + userData['image']
        : "";
    user.token = "Bearer " + token;

    return user;
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullname,
    required String identityNumber,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender,
    required String address,
  }) async {
    var url = Uri.parse("${BaseUrl}/auth/register");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode({
      "full_name": fullname,
      "email": email,
      "password": password,
      "identity_number": identityNumber,
      "phone": phoneNumber,
      "birth_date": dateOfBirth,
      "gender": gender,
      "address": address
    });
    final response = await http.post(url, headers: headers, body: body);

    print(response);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return login(email: email, password: password);
    } else {
      throw ('Tidak Dapat Login');
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    var url = Uri.parse("${BaseUrl}/auth/forgot-password");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode({"email": email});
    final response = await http.post(url, headers: headers, body: body);

    var userData = jsonDecode(response.body)['data'];

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
