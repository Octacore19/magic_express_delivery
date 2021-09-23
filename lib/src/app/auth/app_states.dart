part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.isRider,
    required this.status,
    this.user = User.empty,
  });

  factory AppState.unknown(bool isRider) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.unknown,
    );
  }

  factory AppState.authenticated(bool isRider, User user) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.loggedIn,
      user: user,
    );
  }

  factory AppState.unauthenticated(bool isRider) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.loggedOut,
    );
  }

  final bool isRider;
  final AuthStatus status;
  final User user;

  @override
  List<Object?> get props => [isRider, status, user];
}
