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
  runApp(AppWrapper(App()));
}

class AppWrapper extends StatefulWidget {
  final Widget child;

  AppWrapper(this.child);

  @override
  State<StatefulWidget> createState() => AppWrapperState();
}

class AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  AppWrapperState() : _binding = WidgetsBinding.instance!;

  final WidgetsBinding _binding;

  @override
  void initState() {
    _binding.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _binding.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
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
            // final repo = ;
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
          create: (context) => OrdersRepo(
            api: RepositoryProvider.of(context),
          ),
        ),
      ],
      child: widget.child,
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

  @override
  Future<bool> didPopRoute() async {
    context.read<AuthRepo>().dispose();
    context.read<PlacesRepo>().dispose();
    context.read<OrdersRepo>().dispose();
    return false;
  }
}
