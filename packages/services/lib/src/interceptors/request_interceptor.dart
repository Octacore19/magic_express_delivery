import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';

class RequestInterceptor extends Interceptor {
  RequestInterceptor({
    required Preferences preference,
    required Dio dio,
  })  : _preference = preference,
        _dio = dio;

  final Preferences _preference;
  final Dio _dio;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('no_token')) {
      options.headers.remove(ApiConstants.NO_TOKEN);
    } else {
      final token = await _preference.read<String>(key: ApiConstants.TOKEN);
      if (token != null && token.isNotEmpty) {
        if (await _tokenAboutToExpire()) {
          final error = DioError(
            requestOptions: options,
            type: DioErrorType.response,
            response: Response(statusCode: 401, requestOptions: options),
          );
          handler.reject(error);
        } else
          options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  Future<bool> _tokenAboutToExpire() async {
    String timeStamp =
        await _preference.read<String>(key: ApiConstants.TIME_STAMP) ?? '';
    if (timeStamp.isNotEmpty) {
      final DateTime ex = DateTime.parse(timeStamp);
      final DateTime current = DateTime.now();
      return current.isAfter(ex) ||
          (current.isAfter(ex.subtract(Duration(minutes: 15))) &&
              current.isBefore(ex));
    }
    return true;
  }
}
