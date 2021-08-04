import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:repositories/repositories.dart';

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
              navigator.pushNamedAndRemoveUntil<void>(
                AppRoutes.DASHBOARD,
                (r) => false,
              );
              print('Logged in state');
              break;
            case AuthStatus.registered:
            case AuthStatus.loggedOut:
              print('Logged out state');
              navigator.pushNamedAndRemoveUntil<void>(
                AppRoutes.LOGIN,
                (r) => false,
              );
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
