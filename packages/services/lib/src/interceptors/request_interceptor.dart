import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';

class RequestInterceptor extends Interceptor {
  final Cache _cache;
  final Dio _dio;

  RequestInterceptor({
    required Cache cache,
    required Dio dio,
  }) : _cache = cache, _dio = dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('no_token')) {
      options.headers.remove(ApiConstants.NO_TOKEN);
    } else {
      await _cache.read<String>(key: ApiConstants.TOKEN).then((value) {
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $value';
        }
      });
    }
    handler.next(options);
  }
}
