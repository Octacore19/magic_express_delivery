import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';

class ResponseInterceptor extends Interceptor {
  final Cache _cache;

  ResponseInterceptor({
    required Cache cache,
  }) : _cache = cache;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic> newData = {};
    final data = response.data;

    if (response.requestOptions.uri
        .toString()
        .contains(ApiEndpoints.LOGIN_USER)) {
      _cache.write<String>(
          key: ApiConstants.TOKEN, value: data['data'][ApiConstants.TOKEN]);
      _cache.write<int>(
          key: ApiConstants.TIME_STAMP,
          value: DateTime.now().millisecondsSinceEpoch);
    }

    if (data is Map && data.containsKey('predictions')) {
      newData = {
        'data': {'data': data['predictions']},
        'message': '',
        'code': response.statusCode,
        'success': true,
      };
    } else {
      newData = {
        'data': data,
        'message': '',
        'code': response.statusCode,
        'success': true,
      };
    }
    response.data = newData;
    handler.next(response);
  }
}
