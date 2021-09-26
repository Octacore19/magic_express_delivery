import 'package:dio/dio.dart';
import 'package:services/services.dart';
import 'package:services/src/commons/commons.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor({
    required Preferences preference,
  }) : _preference = preference;

  final Preferences _preference;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map<String, dynamic> newData = {};
    final data = response.data;

    if (response.requestOptions.uri
        .toString()
        .contains(ApiEndpoints.LOGIN_USER)) {
      final now = DateTime.now();
      _preference.write<String>(
        key: ApiConstants.TOKEN,
        value: data['data'][ApiConstants.TOKEN],
      );
      String? expires = data['data']['expires_in'];
      final t = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        int.tryParse(expires ?? '') ?? 0,
      );
      _preference.write<String>(
        key: ApiConstants.TIME_STAMP,
        value: t.toIso8601String(),
      );
    }

    if (data is Map && data.containsKey('predictions')) {
      newData = {
        'data': {'data': data['predictions']},
        'message': '',
        'code': response.statusCode,
        'success': true,
      };
    } else if (data is Map && data.containsKey('result')) {
      newData = {
        'data': {'data': data['result']},
        'message': '',
        'code': response.statusCode,
        'success': true,
      };
    } else if(data is Map && !data.containsKey('data')) {
      newData = {
        'data': {'data': data},
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
