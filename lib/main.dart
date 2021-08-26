import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:services/services.dart';

import 'src/app/app.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
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
        create: (context) => AuthService(api: RepositoryProvider.of(context)),
      ),
      RepositoryProvider(
        create: (context) {
          final repo = AuthRepo(
            preference: RepositoryProvider.of(context),
            authService: RepositoryProvider.of(context),
          );
          repo.status.first;
          return repo;
        },
      ),
    ],
    child: App(),
  ));
}
