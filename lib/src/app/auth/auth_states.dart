part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = User.empty,
  });

  const AuthState.unknown() : this._(status: AuthStatus.unknown);

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.loggedIn, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.loggedOut);

  final AuthStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}
