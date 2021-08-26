import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/interceptors/interceptors.dart';

class ApiProvider {
  final Preferences _preference;
  late Dio _mainDio;
  late Dio _googleDio;

  ApiProvider({required Preferences preference}) : _preference = preference {
    init();
  }

  void init() {
    var mainOption = BaseOptions(
      baseUrl: ApiConstants.BASE_URL,
      connectTimeout: ApiConstants.CONNECT_TIMEOUT,
      receiveTimeout: ApiConstants.RECEIVE_TIMEOUT,
    );
    var googleOption = BaseOptions(
      baseUrl: ApiConstants.BASE_URL,
      connectTimeout: ApiConstants.CONNECT_TIMEOUT,
      receiveTimeout: ApiConstants.RECEIVE_TIMEOUT,
    );
    _mainDio = Dio(mainOption);
    _googleDio = Dio(googleOption);
    _setInterceptors(_mainDio, _preference);
    _setInterceptors(_googleDio, _preference);
  }

  void _setInterceptors(Dio dio, Preferences preference) {
    dio.interceptors.addAll([
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (d) {
          log(d.toString());
        },
      ),
      RequestInterceptor(
        preference: preference,
        dio: dio,
      ),
      ResponseInterceptor(preference: preference),
      ErrorInterceptor(),
    ]);
  }

  Dio get mainInstance => _mainDio;
  Dio get googleInstance => _googleDio;
}
