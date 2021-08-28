import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(authRepo: RepositoryProvider.of(context)),
      child: const AppView(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage();

  static Page route() => const MaterialPage<void>(child: const LoadingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
