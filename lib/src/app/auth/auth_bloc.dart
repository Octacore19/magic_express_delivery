import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthState.unknown()) {
    _statusSubscription = _authRepo.status.listen(_onStatusChanged);
    _authRepo.onAppLaunch();
  }

  final AuthRepo _authRepo;
  late final StreamSubscription<AuthStatus> _statusSubscription;

  void _onStatusChanged(AuthStatus status) => add(AuthenticationStatusChanged(status));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authRepo.logOut();
    }
  }

  Future<AuthState> _mapAuthenticationChangedToState(AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthStatus.loggedOut:
        return AuthState.unauthenticated();
      case AuthStatus.loggedIn:
        final user = await _authRepo.currentUser;
        return user.isEmpty ? AuthState.unauthenticated() : AuthState.authenticated(user);
      default:
        return const AuthState.unknown();
    }
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
