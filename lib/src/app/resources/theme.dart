import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static ThemeData theme(BuildContext context) => ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
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
  );
}