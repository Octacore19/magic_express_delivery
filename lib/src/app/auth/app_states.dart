part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.unknown() : this._(status: AuthStatus.unknown);

  const AppState.authenticated(User user)
      : this._(status: AuthStatus.loggedIn, user: user);

  const AppState.unauthenticated() : this._(status: AuthStatus.loggedOut);

  final AuthStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}
