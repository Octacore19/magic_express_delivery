import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:magic_express_delivery/src/models/models.dart';
import 'package:repositories/repositories.dart';

class FindRiderState extends Equatable {
  const FindRiderState._({
    required Status status,
    required this.detail,
  }) : _status = status;

  factory FindRiderState.init() {
    return FindRiderState._(
      status: Status.loading,
      detail: FCMOrder.empty(),
    );
  }

  factory FindRiderState.success(FCMOrder detail) {
    return FindRiderState._(
      status: Status.success,
      detail: detail,
    );
  }

  final Status _status;
  final FCMOrder detail;

  bool get loading => _status == Status.loading;

  @override
  List<Object?> get props => [_status, detail];
}

class FindRiderCubit extends Cubit<FindRiderState> {
  FindRiderCubit({required UsersRepo repo}) : super(FindRiderState.init()) {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = notification?.android;

      if (notification != null && android != null) {
        print('Notification title: ${notification.title}');
        print('Notification content: ${notification.body}');
      }

      final data = message.data;
      log('Data gotten: $data');
      final fcmData = FCMOrder.fromJson(data);
      emit(FindRiderState.success(fcmData));
      repo.fetchAllHistory();
    });
  }
}
