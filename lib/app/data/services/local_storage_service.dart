import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService extends GetxService {
  Future<AppStorageService> init() async {
    return this;
  }

  Future<void> write(
    String key, {
    String? stringValue,
    int? intValue,
    bool? boolValue,
    double? doublevalue,
  }) async {
    if (stringValue != null) {
      final _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString(key, stringValue);
    }

    if (intValue != null) {
      final _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setInt(key, intValue);
    }

    if (boolValue != null) {
      final _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool(key, boolValue);
    }

    if (doublevalue != null) {
      final _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setDouble(key, doublevalue);
    }
  }

  Future<int?> readInt(String key) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(key);
  }

  Future<String?> readString(String key) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(key);
  }

  Future<bool?> readBool(String key) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(key);
  }

  Future<double?> readDouble(String key) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getDouble(key);
  }

  Future<void> remove(String key) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove(key);
  }
}
