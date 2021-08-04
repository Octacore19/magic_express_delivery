import 'package:flutter/material.dart';
import 'package:magic_express_delivery/src/app/app.dart';
import 'package:magic_express_delivery/src/screens/screens.dart';

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
      case DEFAULT:
        return _buildRoute(settings, LoginScreen());
      case REGISTRATION:
        return _buildRoute(settings, RegistrationScreen());
      case DASHBOARD:
        return _buildRoute(settings, DashboardScreen());
      case DELIVERY:
        final data = settings.arguments as List;
        return _buildRoute(
            settings, DeliveryScreen(data[0], data[1], data[2]));
      case ERRAND:
        final data = settings.arguments as List;
        return _buildRoute(
            settings, ErrandScreen(data[0], data[1], data[2]));
      case DELIVERY_OPTIONS:
        return _buildRoute(
            settings, DeliveryOptionsScreen(settings.arguments as int));
      case PROCESS_DELIVERY:
        final data = settings.arguments as List;
        return _buildRoute(
            settings, ProcessDeliveryScreen(data[0], data[1], data[2]));
      default:
        return _buildRoute(settings, LoginScreen());
    }
  }

  static AppPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return AppPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}