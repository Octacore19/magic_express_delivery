import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';

import 'app_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(authRepo: RepositoryProvider.of(context)),
        ),
        BlocProvider(create: (_) => CoordinatorCubit())
      ],
      child: AppView(),
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
