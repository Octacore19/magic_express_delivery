import 'package:dio/dio.dart';
import 'package:services/src/commons/commons.dart';
import 'package:services/src/local/local.dart';

class ResponseInterceptor extends Interceptor {
  final ICache _cache;

  ResponseInterceptor({
    required ICache cache,
  }) : _cache = cache;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.uri.toString().contains(ApiEndpoints.LOGIN_USER)) {
      final data = response.data;
      _cache.write<String>(key: ApiConstants.TOKEN, value: data['data'][ApiConstants.TOKEN]);
      _cache.write<int>(key: ApiConstants.TIME_STAMP, value: DateTime.now().millisecondsSinceEpoch);
    }
    final newData = {
      'data': response.data['data'],
      'message': response.data['message'],
      'code' : response.statusCode,
      'success': true,
    };

    response.data = newData;
    handler.next(response);
  }
}
