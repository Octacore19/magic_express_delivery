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
        final newData = {
          'data': null,
          'message': _handleError(err),
          'code': err.response?.statusCode ?? null,
          'success': false,
        };
        final newResponse = Response(
          data: newData,
          requestOptions: err.requestOptions,
        );
        handler.resolve(newResponse);
        break;
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";

    if (error.type == DioErrorType.response) {
      final errorData = error.response?.data;
      switch (error.response?.statusCode) {
        case 400:
          if (errorData != null && errorData is Map) {
            if (errorData.containsKey('error_description')) {
              errorDescription = errorData['error_description'];
            } else if (errorData.containsKey('description')) {
              errorDescription = errorData['description'];
            } else if (errorData.containsKey('error')) {
              errorDescription = errorData['error'];
            }
          } else {
            errorDescription = 'An unexpected error occurred';
          }
          break;
        case 404:
          errorDescription = 'No response/connection';
          break;
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
              else
                errorDescription = errorData['message'];
            }
          }
          break;
        default:
          errorDescription = 'An unexpected error occurred';
      }
    }
    return errorDescription;
  }
}
