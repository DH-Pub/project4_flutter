import 'dart:async';

import 'package:dio/dio.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio api = Dio();
  String? accessToken;

  final StreamController<bool> _onAuthStateChange = StreamController.broadcast();
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;
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
            await refreshToken();
            return handler.resolve(await _retry(error.requestOptions));
          }
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

  Future<void> refreshToken() async {
    final refreshToken = prefs.getString(StorageKey.refreshToken);
    final response = await api.post('/auth/refreshtoken', data: {'refreshToken': refreshToken});
    if (response.statusCode == 200) {
      accessToken = response.data["token"];
      String refreshToken = response.data["refreshToken"];
      prefs.setString(StorageKey.token, accessToken!);
      prefs.setString(StorageKey.refreshToken, refreshToken);
    } else {
      accessToken = null;
      prefs.clear();
      _onAuthStateChange.add(false);
    }
  }
}
