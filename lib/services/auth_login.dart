import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLogin {
  Dio api = Dio();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  Future loginUser() async {
    const url = '/auth/login';

    var response = await api.post(url, data: {
      "username": emailController.text,
      "password": passwordController.text,
    });
    if (response.statusCode == 200) {
    } else {}
  }
}
