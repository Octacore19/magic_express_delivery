import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) =>
      ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue[700],
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.blue[900],
        scaffoldBackgroundColor: Colors.white,
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
            primary: Colors.blue[900],
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
      );

  static TextStyle? textFieldHeaderStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2;
  }

  static OutlineInputBorder? textOutlineFocusedBorder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineEnabledBorder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineErrorBorder(BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineErrorFocusedBorder(BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: errorColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }
}
