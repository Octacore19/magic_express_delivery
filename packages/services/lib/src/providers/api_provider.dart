import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/interceptors/interceptors.dart';
import 'package:services/src/local/local.dart';

class ApiProvider {
  final ICache _cache;
  late Dio _dio;
  // late Dio _tokenDio;

  ApiProvider({required ICache cache}) : _cache = cache {
    init();
  }

  void init() {
    var options = BaseOptions(
      baseUrl: ApiConstants.BASE_URL,
      connectTimeout: ApiConstants.CONNECT_TIMEOUT,
      receiveTimeout: ApiConstants.RECEIVE_TIMEOUT,
    );
    _dio = Dio(options);
    _setInterceptors(_dio, _cache);

    // _tokenDio = Dio(options);
  }

  void _setInterceptors(Dio dio, ICache cache) {
    dio.interceptors.addAll([
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (d) {
          log(d.toString());
        },
      ),
      RequestInterceptor(
        cache: cache,
        dio: dio,
      ),
      ResponseInterceptor(cache: cache),
      ErrorInterceptor(),
    ]);
  }

  Dio get instance => _dio;
}
