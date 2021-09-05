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
  AppWrapperState()
      : _binding = WidgetsBinding.instance!,
        _cache = Cache(),
        _preferences = Preferences() {
    _apiProvider = ApiProvider(preference: _preferences);
    _authRepo = AuthRepo(preference: _preferences, api: _apiProvider);
    _placesRepo = PlacesRepo(api: _apiProvider);
  }

  final WidgetsBinding _binding;
  final Cache _cache;
  final Preferences _preferences;

  late ApiProvider _apiProvider;
  late AuthRepo _authRepo;
  late PlacesRepo _placesRepo;

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
        RepositoryProvider(create: (_) => _cache),
        RepositoryProvider(create: (_) => _preferences),
        RepositoryProvider(create: (context) => _apiProvider),
        RepositoryProvider(
          create: (context) {
            _authRepo.status.first;
            return _authRepo;
          },
        ),
        RepositoryProvider(create: (context) => _placesRepo),
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
        _authRepo.dispose();
        _placesRepo.dispose();
        break;
    }
  }

  @override
  Future<bool> didPopRoute() async {
    return false;
  }
}
