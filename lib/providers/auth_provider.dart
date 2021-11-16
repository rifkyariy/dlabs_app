import 'package:dlabs_apps/models/user_model.dart';
import 'package:dlabs_apps/screens/Auth/forgot_password.dart';
import 'package:dlabs_apps/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  late UserModel? _user;
  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;

      return true;
    } catch (e) {
      print("error : $e");
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullname,
    required String identityNumber,
    required String phoneNumber,
    required String dateOfBirth,
    required String? gender,
    required String address,
  }) async {
    try {
      UserModel user = await AuthService().register(
          email: email,
          password: password,
          fullname: fullname,
          identityNumber: identityNumber,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          gender: gender ?? "",
          address: address);
      _user = user;

      return true;
    } catch (e) {
      print("error : $e");
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    try {
      print(email);
      return await AuthService().forgotPassword(email: email);
    } catch (e) {
      print("error : $e");
      return false;
    }
  }
}
