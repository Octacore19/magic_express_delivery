part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested  extends AuthEvent {}

class AuthenticationStatusChanged  extends AuthEvent {

  const AuthenticationStatusChanged (this.status);

  final AuthStatus status;

  @override
  List<Object> get props => [status];
}