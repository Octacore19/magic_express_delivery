import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:magic_express_delivery/src/utils/utils.dart';
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
    _initBloc();
    if (isRider) {
      FirebaseMessaging.onMessage.listen((message) async {
        final notification = message.notification;
        final android = notification?.android;
        final context = AppKeys.navigatorKey.currentState?.context;

        if (notification != null && android != null && context != null) {
          print('Notification title: ${notification.title}');
          print('Notification content: ${notification.body}');
          bool value = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                side: BorderSide(),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    notification.title ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  Image(
                    image: AssetImage(AppImages.DELIVERY_IMAGE),
                    height: MediaQuery.of(context).size.width * 0.25,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    notification.body ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(true);
                      },
                      child: Text('VIEW'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          if (value) {
            final data = message.data;
            log('Data gotten => $data');
            final fcmData = FCMOrder.fromJson(data);
            add(OnMessageReceived(fcmData));
          }
        }
      });
    }
  }

  final AuthRepo _authRepo;
  final UsersRepo? _usersRepo;
  final RidersRepo? _ridersRepo;
  final MiscRepo _miscRepo;
  late final StreamSubscription<AuthStatus> _statusSubscription;

  void _onStatusChanged(AuthStatus status) =>
      add(AuthenticationStatusChanged(status));

  void _initBloc() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (state.isRider) {
        final data = initialMessage.data;
        log('Data gotten => $data');
        final fcmData = FCMOrder.fromJson(data);
        add(OnMessageReceived(fcmData));
      }
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = message.data;
      log('Data gotten => $data');
      final fcmData = FCMOrder.fromJson(data);
      add(OnMessageReceived(fcmData));
    });
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authRepo.logOut();
    } else if (event is OnMessageReceived) {
      _ridersRepo?.fetchAllHistory();
      yield state.copyWith(order: event.order);
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
