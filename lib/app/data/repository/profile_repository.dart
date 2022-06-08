import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  static Future<void> updateProfileData({
    String? path,
    required String token,
    required String userId,
    required String fullName,
    required String identityNumber,
    required String phone,
    required String birthDate,
    required String gender,
    required String address,
    required String nationality,
  }) async {
    const String _kbaseUrl = "https://api-dl.konsultasi.in/v1/web";
    final _dio = Dio();

    try {
      String? _fileName;
      if (path != null) {
        _fileName = path.split('/').last;
      }
      Map<String, dynamic> _fileMap;

      if (_fileName != '' || _fileName != null) {
        if (path != null) {
          _fileMap = {
            "file": await MultipartFile.fromFile(
              path,
              filename: _fileName,
            ),
            "fullname": fullName,
            "identitynumber": identityNumber,
            "phone": phone,
            "birthdate": birthDate,
            "gender": gender,
            "address": address,
            "nationality": nationality,
          };
        } else {
          _fileMap = {
            "fullname": fullName,
            "identitynumber": identityNumber,
            "phone": phone,
            "birthdate": birthDate,
            "gender": gender,
            "address": address,
            "nationality": nationality,
          };
        }

        print(_fileMap);
      } else {
        return;
      }

      FormData formData = FormData.fromMap(_fileMap);

      await _dio.post(
        '$_kbaseUrl/profile/update/$userId',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data;',
            'fendpoint': '/profile',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> sendContactUs({
    required String email,
    required String fullname,
    required String phone,
    required String subject,
    required String message,
  }) async {
    const String _kbaseUrl = "https://api-dl.konsultasi.in/v1/web";
    final url = Uri.parse("$_kbaseUrl/content/contact/create");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'fendpoint': '/web-content',
    };

    final body = jsonEncode(
      {
        "email": email,
        "full_name": fullname,
        "phone": phone,
        "subject": subject,
        "message": message
      },
    );

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
}
