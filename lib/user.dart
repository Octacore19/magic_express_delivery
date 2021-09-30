import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      'This channel is used for important notifications.',
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

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
}
