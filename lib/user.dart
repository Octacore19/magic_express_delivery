import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = MyBlocObserver();
      await Firebase.initializeApp();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getTemporaryDirectory(),
      );
      await FirebaseMessaging.instance.requestPermission();

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      runApp(MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => Cache()),
          RepositoryProvider(create: (context) => ErrorHandler()),
          RepositoryProvider(create: (_) => Preferences()),
          RepositoryProvider(
            create: (context) => ApiProvider(
              preference: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider(
            create: (context) {
              return AuthRepo(
                preference: RepositoryProvider.of(context),
                api: RepositoryProvider.of(context),
                isRider: false,
              )..onAppLaunch();
            },
          ),
          RepositoryProvider(
            create: (context) => PlacesRepo(
              api: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider(
            create: (context) => UsersRepo(
              api: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider(
            create: (context) => MiscRepo(
              api: RepositoryProvider.of(context),
            ),
          ),
          RepositoryProvider(
            create: (context) => NotificationRepo(
              api: RepositoryProvider.of(context),
            ),
          )
        ],
        child: App(),
      ));
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
