import 'package:dio/dio.dart';
import 'package:magic_express_delivery/src/index.dart';

class ResponseInterceptor extends Interceptor {
  final IPreferences preferences;

  ResponseInterceptor({
    required this.preferences,
  });

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.uri.toString().contains(ApiEndpoints.LOGIN_USER)) {
      final data = response.data;
      preferences.setData(ApiConstants.TOKEN, data['data'][ApiConstants.TOKEN]);
      preferences.setData(ApiConstants.TIME_STAMP, DateTime.now().millisecondsSinceEpoch);
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
