import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  static late SharedPreferences prefs;
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Dio api = Dio();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  Future<bool> loginUser() async {
    const url = '${API_CONSTANTS.baseUrl}/auth/login';

    try {
      var response = await api.post(url, data: {
        "username": emailController.text,
        "password": passwordController.text,
      });
      if (response.statusCode == 200) {
        String token = response.data["token"];
        String refreshToken = response.data["refreshToken"];
        prefs.setString(StorageKey.token, token);
        prefs.setString(StorageKey.refreshToken, refreshToken);

        _onAuthStateChange.add(true);
        return true;
      } else {
        errorMessage = "Invalid email or password";
        _onAuthStateChange.add(false);
        return false;
      }
    } catch (e) {
      errorMessage = "Invalid email or password";
      _onAuthStateChange.add(false);
      return false;
    }
  }

  void logOut() {
    _onAuthStateChange.add(false);
  }
}
