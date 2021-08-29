import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => Cache()),
      RepositoryProvider(create: (_) => Preferences()),
      RepositoryProvider(
        create: (context) => ApiProvider(
          preference: RepositoryProvider.of(context),
        ),
      ),
      RepositoryProvider(
        create: (context) {
          final repo = AuthRepo(
            preference: RepositoryProvider.of(context),
            api: RepositoryProvider.of(context),
          );
          repo.status.first;
          return repo;
        },
      ),
      RepositoryProvider(
        create: (context) => PlacesRepo(api: RepositoryProvider.of(context)),
      ),
    ],
    child: App(),
  ));
}
