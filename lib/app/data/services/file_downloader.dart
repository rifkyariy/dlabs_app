import 'dart:io';

import 'package:dio/dio.dart';

class FileDownloader {
  static Future<void> downloadFile({
    required url,
    required String path,
    Function(int, int)? onReceiveProgress,
  }) async {
    final Dio _dio = Dio();
    final File _file = File(path);

    try {
      final _resopnse = await _dio.get(
        url,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      final _raf = _file.openSync(mode: FileMode.write);
      _raf.writeFromSync(_resopnse.data);
      await _raf.close();
    } catch (e) {
      print(e.toString());
    }
  }
}
