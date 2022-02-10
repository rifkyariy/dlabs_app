import 'package:dio/dio.dart';

class ProfileRepository {
  static Future<void> uploadProfilePicture({
    required String path,
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
      final String _fileName = path.split('/').last;
      Map<String, dynamic> _fileMap;
      if (_fileName != "") {
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
