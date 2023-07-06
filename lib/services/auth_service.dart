import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';

class AuthService {
  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  Dio api = Dio();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = "";

  final _storage = const FlutterSecureStorage();
  Future<bool> loginUser() async {
    const url = '${ApiConstants.baseUrl}/auth/login';

    try {
      var response = await api.post(url, data: {
        "username": emailController.text,
        "password": passwordController.text,
      });
      if (response.statusCode == 200) {
        String token = response.data["token"];
        String refreshToken = response.data["refreshToken"];
        _storage.write(key: StorageKey.token, value: token);
        _storage.write(key: StorageKey.refreshToken, value: refreshToken);

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
