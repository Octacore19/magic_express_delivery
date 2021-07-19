// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_express_delivery/src/index.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector.get<LoginBloc>()),
        BlocProvider(create: (_) => injector.get<RegistrationBloc>())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Express Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue[700],
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.blue[900],
        accentColor: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.button,
            primary: Colors.blue[900],
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.button,
            primary: Colors.blue[700],
          ),
        ),
        textTheme: GoogleFonts.workSansTextTheme(
          Theme.of(context).textTheme.apply(
                displayColor: Colors.blue[900],
                bodyColor: Colors.blue[900],
              ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          textTheme: Theme.of(context).textTheme.apply(
                displayColor: Colors.blue[900],
                bodyColor: Colors.blue[900],
              ),
          titleTextStyle: Theme.of(context).textTheme.headline1,
          iconTheme: IconThemeData(
            color: Colors.blue[900],
          ),
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.DEFAULT:
            return _buildRoute(settings, LoginScreen());
          case Routes.REGISTRATION:
            return _buildRoute(settings, RegistrationScreen());
          case Routes.DASHBOARD:
            return _buildRoute(settings, DashboardScreen());
          case Routes.DELIVERY:
            final data = settings.arguments as List;
            return _buildRoute(settings, DeliveryScreen(data[0], data[1]));
          case Routes.ERRAND:
            final data = settings.arguments as List;
            return _buildRoute(settings, ErrandScreen(data[0], data[1]));
          case Routes.DELIVERY_OPTIONS:
            return _buildRoute(
                settings, DeliveryOptionsScreen(settings.arguments));
          case Routes.PROCESS_DELIVERY:
            final data = settings.arguments as List;
            return _buildRoute(
                settings, ProcessDeliveryScreen(data[0], data[1]));
          default:
            return _buildRoute(settings, LoginScreen());
        }
      },
    );
  }

  _MyPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return _MyPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  @override
  void dispose() {
    injector.dispose();
    super.dispose();
  }
}

class _MyPageRoute<T> extends MaterialPageRoute<T> {
  _MyPageRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
