// @dart=2.9

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_express_delivery/src/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          iconTheme: IconThemeData(
            color: Colors.blue[900],
          ),
        ),
      ),
      routes: {
        Routes.DEFAULT: (_) => LoginScreen(),
        Routes.REGISTRATION: (_) => RegistrationScreen(),
        Routes.DASHBOARD: (_) => DashboardScreen(),
        Routes.DELIVERY: (_) => DeliveryScreen(),
        Routes.ERRAND: (_) => ErrandScreen(),
      },
    );
  }
}
