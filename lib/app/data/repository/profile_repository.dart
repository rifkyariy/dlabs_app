import 'package:dio/dio.dart';

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
    const String _kbaseUrl = "https://api-lims.kayabe.id/v1/web";

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
}
