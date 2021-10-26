import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static AppPageRoute generateRoute({
    required Widget child,
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
