part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested  extends AppEvent {}

class AuthenticationStatusChanged  extends AppEvent {

  const AuthenticationStatusChanged (this.status);

  final AuthStatus status;

  @override
  List<Object> get props => [status];
}