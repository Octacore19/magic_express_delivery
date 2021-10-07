part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    required this.isRider,
    required this.status,
    this.user = User.empty,
    required this.order,
  });

  factory AppState.unknown(bool isRider) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.unknown,
      order: FCMOrder.empty(),
    );
  }

  factory AppState.authenticated(bool isRider, User user) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.loggedIn,
      user: user,
      order: FCMOrder.empty(),
    );
  }

  factory AppState.unauthenticated(bool isRider) {
    return AppState._(
      isRider: isRider,
      status: AuthStatus.loggedOut,
      order: FCMOrder.empty(),
    );
  }

  final bool isRider;
  final AuthStatus status;
  final User user;
  final FCMOrder order;

  AppState copyWith({FCMOrder? order}) {
    return AppState._(
      isRider: isRider,
      status: status,
      user: user,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [isRider, status, user, order];
}
