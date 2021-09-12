import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepo authRepo,
    required OrdersRepo ordersRepo,
  })  : _authRepo = authRepo,
        _ordersRepo = ordersRepo,
        super(AuthState.unknown()) {
    _statusSubscription = _authRepo.status.listen(_onStatusChanged);
  }

  final AuthRepo _authRepo;
  final OrdersRepo _ordersRepo;
  late final StreamSubscription<AuthStatus> _statusSubscription;

  void _onStatusChanged(AuthStatus status) =>
      add(AuthenticationStatusChanged(status));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authRepo.logOut();
    }
  }

  Future<AuthState> _mapAuthenticationChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthStatus.loggedOut:
        return AuthState.unauthenticated();
      case AuthStatus.loggedIn:
        final user = await _authRepo.currentUser;
        if (user.isEmpty) {
          return AuthState.unauthenticated();
        }
        _fetchHistory();
        return AuthState.authenticated(user);
      default:
        return const AuthState.unknown();
    }
  }

  _fetchHistory() async {
    try {
      await _ordersRepo.fetchAllHistory();
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
