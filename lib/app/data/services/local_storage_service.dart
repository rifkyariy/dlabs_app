import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<AppStorageService> init() async {
    return this;
  }

  @override
  void onInit() async {
    super.onInit();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void write(
    String key, {
    String? stringValue,
    int? intValue,
    bool? boolValue,
    double? doublevalue,
  }) {
    if (stringValue != null) {
      sharedPreferences.setString(key, stringValue);
    }

    if (intValue != null) {
      sharedPreferences.setInt(key, intValue);
    }

    if (boolValue != null) {
      sharedPreferences.setBool(key, boolValue);
    }

    if (doublevalue != null) {
      sharedPreferences.setDouble(key, doublevalue);
    }
  }
}
