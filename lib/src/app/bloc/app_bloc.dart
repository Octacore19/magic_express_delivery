import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'app_events.dart';

part 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AppState.unknown()) {
    _statusSubscription = _authRepo.status.listen(_onStatusChanged);
  }

  final AuthRepo _authRepo;
  late final StreamSubscription<AuthStatus> _statusSubscription;

  void _onStatusChanged(AuthStatus status) => add(AuthenticationStatusChanged(status));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationChangedToState(event, state);
    } else if (event is AuthenticationLogoutRequested) {
      _authRepo.logOut();
    }
  }

  Future<AppState> _mapAuthenticationChangedToState(AuthenticationStatusChanged event, AppState state) async {
    switch (event.status) {
      case AuthStatus.registered:
        return const AppState.registered();
      case AuthStatus.loggedOut:
        return AppState.unauthenticated();
      case AuthStatus.loggedIn:
        final user = await _authRepo.currentUser;
        return user.isEmpty ? AppState.unauthenticated() : AppState.authenticated(user);
      default:
        return const AppState.unknown();
    }
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
