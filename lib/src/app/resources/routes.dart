import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/dashboard/dashboard_page.dart';
import 'package:magic_express_delivery/src/login/login.dart';
import 'package:magic_express_delivery/src/registration/registration.dart';
import 'package:repositories/repositories.dart';

class AppRoutes {
  static const DEFAULT = '/';
  static const LOGIN = '/login';
  static const REGISTRATION = '/registration';
  static const DASHBOARD = '/dashboard';
  static const ERRAND = '/errand';
  static const DELIVERY = '/delivery';
  static const DELIVERY_OPTIONS = '/options';
  static const PROCESS_DELIVERY = '/process delivery';

  static AppPageRoute generatePageRoute(RouteSettings settings) {
    switch (settings.name) {
      case REGISTRATION:
        return buildRoute(RegistrationPage(), settings);
      default:
        return buildRoute(LoginPage(), settings);
    }
  }

  static List<Page> onGenerateAppViewPages(AuthStatus state, List<Page<dynamic>> pages) {
    switch (state) {
      case AuthStatus.loggedIn:
        return [DashboardPage.route()];
      case AuthStatus.loggedOut:
      case AuthStatus.registered:
      default:
        return [LoginPage.route()];
    }
  }

  static AppPageRoute buildRoute(Widget builder, [RouteSettings? settings]) {
    return AppPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute(
      {required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}