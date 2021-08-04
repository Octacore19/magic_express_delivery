import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

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

class AppView extends StatefulWidget {
  const AppView();

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {

  final _navigationKey = GlobalKey<NavigatorState>();

  NavigatorState get navigator => _navigationKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationKey,
      title: 'Magic Express Delivery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      builder: (_, child) => BlocListener<AppBloc, AppState>(
        listener: (_, state) {
          switch (state.status) {
            case AuthStatus.loggedIn:
              navigator.pushReplacementNamed(AppRoutes.DASHBOARD);
              print('Logged in state');
              break;
            case AuthStatus.registered:
            case AuthStatus.loggedOut:
              print('Logged out state');
              navigator.pushNamed(AppRoutes.LOGIN);
              break;
            case AuthStatus.unknown:
            default:
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: AppRoutes.generatePageRoute,
    );
  }
}
