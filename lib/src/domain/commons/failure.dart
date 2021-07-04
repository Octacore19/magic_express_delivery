// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';

/// [Failure] is a wrapper around the exception that happens on the repository
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure {
  final String message;

  AuthFailure({this.message = ''});
}

class ServerFailure extends Failure {
  final String serverMessage;
  ServerFailure({this.serverMessage = ''});
}

class CacheFailure extends Failure {}