abstract class BaseException implements Exception {
  const BaseException([this.message = '']);

  final String? message;

  @override
  String toString() => "${runtimeType.toString()}: $message";
}

class AuthenticationException extends BaseException {
  const AuthenticationException([String message = '']) : super(message);
}

class RequestFailureException extends BaseException {
  const RequestFailureException([String message = '']) : super(message);
}

class NoDataException extends BaseException {
  const NoDataException([String message = '']) : super(message);
}

class NoElementException extends BaseException {
  const NoElementException([String message = '']) : super(message);
}
