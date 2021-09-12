import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

import 'app_view.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final WidgetsBinding _binding = WidgetsBinding.instance!;

  @override
  void initState() {
    _binding.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _binding.removeObserver(this);
    context.read<AuthRepo>().dispose();
    context.read<PlacesRepo>().dispose();
    context.read<OrdersRepo>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepo: RepositoryProvider.of(context),
            ordersRepo: RepositoryProvider.of(context),
          ),
        ),
        BlocProvider(create: (_) => CoordinatorCubit())
      ],
      child: AppView(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        context.read<AuthRepo>().dispose();
        context.read<PlacesRepo>().dispose();
        context.read<OrdersRepo>().dispose();
        break;
    }
  }
}
