import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class ApiProvider {
  final String _baseUrl;
  final IPreferences preferences;
  late Dio _dio;
  // late Dio _tokenDio;

  ApiProvider(this._baseUrl, {required this.preferences});

  void init() {
    var options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: ApiConstants.CONNECT_TIMEOUT,
      receiveTimeout: ApiConstants.RECEIVE_TIMEOUT,
    );
    _dio = Dio(options);
    // _tokenDio = Dio(options);
  }

  void setInterceptors() {
    _dio.interceptors.addAll([
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (d) {
          log(d.toString());
        },
      ),
      RequestInterceptor(
        preferences: preferences,
        dio: _dio,
      ),
      ResponseInterceptor(preferences: preferences),
      ErrorInterceptor(),
    ]);
  }

  Dio get dioInstance => _dio;
}
