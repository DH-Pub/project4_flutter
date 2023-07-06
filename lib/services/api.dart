import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/storage_key.dart';

class Api {
  Dio api = Dio();
  String? accessToken;

  final _storage = const FlutterSecureStorage();

  Api() {
    api.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!options.path.contains('http')) {
          options.path = ApiConstants.baseUrl + options.path;
        }
        if (await _storage.containsKey(key: StorageKey.token)) {
          accessToken = await _storage.read(key: StorageKey.token);
        }

        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          if (await _storage.containsKey(key: StorageKey.refreshToken)) {
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
    final refreshToken = await _storage.read(key: StorageKey.refreshToken);
    final response = await api.post('/auth/refreshtoken', data: {'refreshToken': refreshToken});
    if (response.statusCode == 200) {
      accessToken = response.data;
    } else {
      accessToken = null;
      _storage.deleteAll();
    }
  }
}
