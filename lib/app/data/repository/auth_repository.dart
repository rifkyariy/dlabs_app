import 'dart:convert';
import 'package:dlabs_apps/app/core/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dlabs_apps/app/data/models/user_model.dart';

class AuthRepository {
  final String baseUrl = "https://api-lims.kayabe.id/v1/web";

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("$baseUrl/auth/login");
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': basicAuthenticationHeader(email, password)
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return getUserData(token: data['token']);
    } else {
      String error = jsonDecode(response.body)['errors'];
      return UserModel(errors: error);
    }
  }

  Future<UserModel> getUserData({required String token}) async {
    var url = Uri.parse("$baseUrl/profile/me");

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/profile',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(userData);
      user.image = userData.containsKey('image')
          ? "https://api-lims.kayabe.id/" + userData['image']
          : "";
      user.token = token;
      user.status = jsonDecode(response.body)['status'];
      user.errors = jsonDecode(response.body)['errors'];
      return user;
    } else {
      return UserModel(
        status: jsonDecode(response.body)['status'],
        errors: jsonDecode(response.body)['message'],
      );
    }
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String fullname,
    required String identityNumber,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender,
    required String address,
  }) async {
    var url = Uri.parse("$baseUrl/auth/register");
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return login(email: email, password: password);
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

  Future<bool> forgotPassword({required String email}) async {
    final url = Uri.parse("$baseUrl/auth/forgot-password");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode({"email": email});
    final response = await http.post(url, headers: headers, body: body);

    final userData = jsonDecode(response.body)['data'];

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<_GoogleUserStatus?> verifyGoogleAccount({
    required String accessToken,
    required String displayName,
  }) async {
    final url = Uri.parse("$baseUrl/auth/google/verify");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    final body = jsonEncode(
      {
        "access_token": accessToken,
        "full_name": displayName,
      },
    );

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body)['data'];

      if (response.statusCode == 200) {
        return _GoogleUserStatus(
          status: jsonDecode(response.body)['status'],
          email: data['email'],
          isRegistered: data['isRegistered'],
          token: data['token'],
          password: data['password'],
        );
      } else if (response.statusCode == 404) {
        return _GoogleUserStatus(
          status: jsonDecode(response.body)['status'],
          errors: jsonDecode(response.body)['errors'],
        );
      } else {
        // if no response from server return null
        return _GoogleUserStatus();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "$e",
        backgroundColor: dangerColor,
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        colorText: whiteColor,
      );
    }
  }
}

class _GoogleUserStatus {
  final String? email;
  final int? isRegistered;
  final String? token;
  final String? status;
  final String? errors;
  final String? password;

  _GoogleUserStatus({
    this.errors,
    this.status,
    this.email,
    this.isRegistered,
    this.token,
    this.password,
  });
}
