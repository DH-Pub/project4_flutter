import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/models/user.dart';
import 'package:proj4_flutter/services/api.dart';

class UserController {
  Dio dio = Dio();
  Api userApi = Api();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String errMsg = "";

  Future<User?> signup() async {
    if (emailController.text.isEmpty) {
      errMsg = "Email cannot be empty.";
      return null;
    } else if (usernameController.text.isEmpty) {
      errMsg = "Username cannot be empty.";
      return null;
    } else if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      errMsg = "Password and confirm password cannot be empty.";
      return null;
    }
    if (passwordController.text != confirmPasswordController.text) {
      errMsg = "Password and confirm password does not match.";
      return null;
    }
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (!regex.hasMatch(passwordController.text)) {
      errMsg = "Password should contain 1 upper, 1 lower, 1 digit, and atleast 8 characters.";
      return null;
    }
    errMsg = '';
    final userDetail = json.encode({
      "email": emailController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "bio": bioController.text,
    });
    final formData = FormData.fromMap({
      'user': MultipartFile.fromString(userDetail, contentType: MediaType.parse('application/json')),
    });
    User? result;
    await dio
        .post("${API_CONSTANTS.user}/signup", data: formData)
        .then((value) => result = User.fromJson(value.data))
        .catchError((err) => errMsg = err.response.data);
    return result;
  }

  Future<User?> getAccount() async {
    User? result;
    await userApi.api
        .get("${API_CONSTANTS.user}/account")
        .then((value) => result = User.fromJson(value.data))
        .catchError((err) => errMsg = err?.response?.data);
    return result;
  }

  Future<User?> updateAccount() async {
    errMsg = '';
    final userDetail = json.encode({
      "username": usernameController.text,
      "bio": bioController.text,
    });
    final formData = FormData.fromMap({
      'user': MultipartFile.fromString(userDetail, contentType: MediaType.parse('application/json')),
    });
    User? result;
    await userApi.api
        .put("${API_CONSTANTS.user}/user/update", data: formData)
        .then((value) => result = User.fromJson(value.data))
        .catchError((e) => errMsg = e.response.data);
    return result;
  }
}
