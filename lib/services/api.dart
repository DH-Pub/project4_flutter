import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends ChangeNotifier {
  Dio api = Dio();
  Dio refresh = Dio();
  String? accessToken;

  late SharedPreferences prefs;

  Api() {
    api.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!options.path.contains('http')) {
          options.path = API_CONSTANTS.baseUrl + options.path;
        }
        prefs = await SharedPreferences.getInstance();
        accessToken = prefs.getString(StorageKey.token);

        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          // if sp has the refresh token
          if (prefs.containsKey(StorageKey.refreshToken)) {
            if (await refreshToken()) {
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
          accessToken = null;
          prefs.clear();
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = prefs.getString(StorageKey.refreshToken);
      final response = await refresh.post(
        '${API_CONSTANTS.baseUrl}/auth/refreshtoken',
        data: {'refreshToken': refreshToken},
      );
      if (response.statusCode == 200) {
        accessToken = response.data["token"];
        String refreshToken = response.data["refreshToken"];
        prefs.setString(StorageKey.token, accessToken!);
        prefs.setString(StorageKey.refreshToken, refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
