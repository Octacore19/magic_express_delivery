import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
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
}

const LocationUpdateTask = 'Rider Location Update';

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == LocationUpdateTask) {
      final preference = Preferences();
      final api = ApiProvider(preference: preference);
      final miscRepo = MiscRepo(api: api);

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        final res = await placemarkFromCoordinates(userLocation.latitude, userLocation.longitude);
        final b = res.first;
        final add = '${b.street} ${b.subAdministrativeArea} ${b.administrativeArea}';
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
