import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:repositories/repositories.dart';

part 'app_events.dart';

part 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepo authRepo,
    required MiscRepo miscRepo,
    required bool isRider,
    UsersRepo? usersRepo,
    RidersRepo? ridersRepo,
  })  : _authRepo = authRepo,
        _usersRepo = usersRepo,
        _miscRepo = miscRepo,
        _ridersRepo = ridersRepo,
        super(AppState.unknown(isRider)) {
    _statusSubscription = _authRepo.status.listen(_onStatusChanged);
  }

  final AuthRepo _authRepo;
  final UsersRepo? _usersRepo;
  final RidersRepo? _ridersRepo;
  final MiscRepo _miscRepo;
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
        _initUserParticles(user.paystackKey);
        return AppState.authenticated(state.isRider, user);
      default:
        return AppState.unknown(state.isRider);
    }
  }

  _initUserParticles(String key) async {
    try {
      if (state.isRider) {
        await _ridersRepo?.fetchAllHistory();
      } else {
        await PaystackClient.initialize(key);
        await _usersRepo?.fetchAllHistory();
        await _miscRepo.fetchChargesFromService();
      }
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) await _miscRepo.updateDeviceToken(token);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _statusSubscription.cancel();
    return super.close();
  }
}
