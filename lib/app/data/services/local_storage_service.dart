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
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(key, stringValue);
    }

    if (intValue != null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setInt(key, intValue);
    }

    if (boolValue != null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool(key, boolValue);
    }

    if (doublevalue != null) {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setDouble(key, doublevalue);
    }
  }

  Future<int?> readInt(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key);
  }

  Future<String?> readString(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  Future<bool?> readBool(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }

  Future<double?> readDouble(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }
}
