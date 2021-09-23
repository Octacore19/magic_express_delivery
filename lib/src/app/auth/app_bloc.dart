import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'app_events.dart';

part 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepo authRepo,
    required OrdersRepo ordersRepo,
    required bool isRider
  })  : _authRepo = authRepo,
        _ordersRepo = ordersRepo,
        super(AppState.unknown(isRider)) {
    _statusSubscription = _authRepo.status.listen(_onStatusChanged);
  }

  final AuthRepo _authRepo;
  final OrdersRepo _ordersRepo;
  late final StreamSubscription<AuthStatus> _statusSubscription;

  void _onStatusChanged(AuthStatus status) =>
      add(AuthenticationStatusChanged(status));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authRepo.logOut();
    }
  }

  Future<AppState> _mapAuthenticationChangedToState(
      AuthenticationStatusChanged event) async {
    switch (event.status) {
      case AuthStatus.loggedOut:
        return AppState.unauthenticated(state.isRider);
      case AuthStatus.loggedIn:
        final user = await _authRepo.currentUser;
        if (user.isEmpty) {
          return AppState.unauthenticated(state.isRider);
        }
        _initUserParticles();
        return AppState.authenticated(state.isRider, user);
      default:
        return AppState.unknown(state.isRider);
    }
  }

  _initUserParticles() async {
    try {
      if (state.isRider) {

      } else {
        await _ordersRepo.fetchAllHistory();
        await _ordersRepo.getCharges();
      }
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
