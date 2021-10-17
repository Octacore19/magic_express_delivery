import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message in rider app ${message.messageId}');
  final data = message.data;
  print('Data gotten => $data');
}

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      Bloc.observer = MyBlocObserver();
      await Firebase.initializeApp();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getTemporaryDirectory(),
      );

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
                isRider: true,
              )..onAppLaunch();
            },
          ),
          RepositoryProvider(
            create: (context) => RidersRepo(
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
        child: App(true),
      ));
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

const LocationUpdateTask = 'Rider Location Update';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == LocationUpdateTask) {
      final preference = Preferences();
      final api = ApiProvider(preference: preference);
      final miscRepo = MiscRepo(api: api);

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final res = await placemarkFromCoordinates(
            userLocation.latitude, userLocation.longitude);
        final b = res.first;
        final add =
            '${b.street} ${b.subAdministrativeArea} ${b.administrativeArea}';
        await miscRepo.updateUserLocation(
          userLocation.latitude,
          userLocation.longitude,
          add,
        );
      }
    }
    return Future.value(true);
  });
}
