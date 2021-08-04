import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  const App({required AuthRepo authRepo}) : _authRepo = authRepo;

  final AuthRepo _authRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepo,
      child: BlocProvider(
        create: (_) => AppBloc(
          authRepo: _authRepo,
        ),
        child: const AppView(),
      ),
    );
  }
}
