import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/pages/pages.dart';
import 'package:repositories/repositories.dart';

class AppRoutes {

  AppRoutes._();

  static List<Page> onGenerateAppViewPages(
    AuthStatus state,
    List<Page<dynamic>> pages,
  ) {
    switch (state) {
      case AuthStatus.loggedIn:
        return [DashboardPage.route()];
      case AuthStatus.loggedOut:
      default:
        return [LoginPage.page()];
    }
  }

  static AppPageRoute generateRoute(
    Widget child, {
    RouteSettings? settings,
    bool fullScreenDialog = false,
  }) {
    return AppPageRoute(
      settings: settings,
      builder: (ctx) => child,
      fullScreenDialog: fullScreenDialog,
    );
  }

  static AppPageRoute generateRouteBuilder({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullScreenDialog = false,
  }) {
    return AppPageRoute(
      settings: settings,
      builder: builder,
      fullScreenDialog: fullScreenDialog,
    );
  }
}

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      bool fullScreenDialog = false})
      : super(
          builder: builder,
          settings: settings,
          fullscreenDialog: fullScreenDialog,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
