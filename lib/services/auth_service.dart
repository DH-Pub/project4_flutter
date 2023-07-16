import 'dart:async';

import 'package:dio/dio.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  late final SharedPreferences prefs;

  AuthService(this.prefs);

  Dio dio = Dio();
  String errorMessage = "";

  Future<bool> loginUser(email, password) async {
    errorMessage = '';
    const url = '${API_CONSTANTS.baseUrl}/auth/login';
    if (email == '' || password == '') {
      errorMessage = "Email and password cannot be empty";
      _onAuthStateChange.add(false);
      return false;
    }
    bool res = false;
    await dio.post(url, data: {
      "username": email,
      "password": password,
    }).then((value) {
      String token = value.data["token"];
      String refreshToken = value.data["refreshToken"];
      prefs.setString(StorageKey.token, token);
      prefs.setString(StorageKey.refreshToken, refreshToken);

      _onAuthStateChange.add(true);
      res = true;
    }).catchError((e) {
      errorMessage = e.response.data;
      _onAuthStateChange.add(false);
    });
    return res;
  }

  void logOut() {
    errorMessage = "";
    _onAuthStateChange.add(false);
  }
}
