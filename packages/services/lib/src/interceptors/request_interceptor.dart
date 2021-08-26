import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';

class RequestInterceptor extends Interceptor {

  RequestInterceptor({
    required Preferences preference,
    required Dio dio,
  }) : _preference = preference, _dio = dio;

  final Preferences _preference;
  final Dio _dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('no_token')) {
      options.headers.remove(ApiConstants.NO_TOKEN);
    } else {
      await _preference.read<String>(key: ApiConstants.TOKEN).then((value) {
        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $value';
        }
      });
    }
    handler.next(options);
  }
}
