import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack_client/flutter_paystack_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';
import 'package:path_provider/path_provider.dart';

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
    ],
    child: App(true),
  ));
}