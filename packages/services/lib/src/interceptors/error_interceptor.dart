import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.cancel:
      case DioErrorType.other:
        handler.reject(err);
        break;
      case DioErrorType.response:
        String errorDescription = "";
        final errorData = err.response?.data;
        switch (err.response?.statusCode) {
          case 422:
            if (errorData != null && errorData is Map) {
              if (errorData.containsKey('errors')) {
                final errors = errorData['errors'];
                if (errors.containsKey('phone_number'))
                  errorDescription = errors['phone_number'].first;
                else if (errors.containsKey('email'))
                  errorDescription = errors['email'].first;
                else if (errors.containsKey('password'))
                  errorDescription = errors['password'].first;
                else {
                  errorDescription = errorData['message'];
                }
                final newData = {
                  'data': null,
                  'message': errorDescription,
                  'code': err.response?.statusCode ?? null,
                  'success': false,
                };
                final newResponse = Response(
                  data: newData,
                  requestOptions: err.requestOptions,
                );
                handler.resolve(newResponse);
              }
            }
            break;
          default:
            handler.reject(err);
            break;
        }
        break;
    }
  }
}
