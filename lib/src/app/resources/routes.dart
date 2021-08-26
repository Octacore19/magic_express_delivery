import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
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
        return generateRoute(RegistrationPage(), settings);
      default:
        return generateRoute(LoginPage(), settings);
    }
  }

  static List<Page> onGenerateAppViewPages(
    AuthStatus state,
    List<Page<dynamic>> pages,
  ) {
    switch (state) {
      case AuthStatus.loggedIn:
        return [DashboardPage.route()];
      case AuthStatus.loggedOut:
      default:
        return [LoginPage.route()];
    }
  }

  static AppPageRoute generateRoute(Widget builder, [RouteSettings? settings]) {
    return AppPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  static AppPageRoute generateRouteBuilder({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) {
    return AppPageRoute(
      settings: settings,
      builder: builder,
    );
  }
}

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
