import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class RequestInterceptor extends Interceptor {
  final IPreferences preferences;
  final Dio dio;

  RequestInterceptor({
    required this.preferences,
    required this.dio,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('no_token')) {
      options.headers.remove(ApiConstants.NO_TOKEN);
    } else {
      await preferences.getData(ApiConstants.TOKEN, '').then((value) {
        if ((value as String).isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $value';
        }
      });
    }
    handler.next(options);
  }
}
