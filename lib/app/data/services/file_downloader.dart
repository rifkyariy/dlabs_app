import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  static Future<void> downloadFile({
    required url,
    required String path,
  }) async {
    final Dio _dio = Dio();
    final File _file = File(path);

    if (await _file.exists()) throw 'file-already-exist';
    final _resopnse = await _dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    if (!(await Permission.storage.isGranted)) {
      if (await Permission.storage.request().isGranted) {
        final _raf = _file.openSync(mode: FileMode.writeOnly);
        _raf.writeFromSync(_resopnse.data);
        await _raf.close();
      }
    } else {
      final _raf = _file.openSync(mode: FileMode.writeOnly);
      _raf.writeFromSync(_resopnse.data);
      await _raf.close();
    }
  }
}
