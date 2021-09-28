import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

import 'app_view.dart';

class App extends StatefulWidget {
  const App([this.isRider = false]);

  final bool isRider;

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
    context.read<UsersRepo>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            authRepo: RepositoryProvider.of(context),
            miscRepo: RepositoryProvider.of(context),
            isRider: widget.isRider,
            usersRepo: widget.isRider ? null : RepositoryProvider.of(context),
            ridersRepo: widget.isRider ? RepositoryProvider.of(context) : null,
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
        context.read<NotificationRepo>().dispose();
        if (widget.isRider) {
          context.read<RidersRepo>().dispose();
        } else {
          context.read<UsersRepo>().dispose();
        }
        break;
    }
  }
}
