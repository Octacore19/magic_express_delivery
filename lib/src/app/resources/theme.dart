import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get userTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue[700],
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.blue[900],
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          shadowColor: Colors.blue[100],
          color: Colors.blue[50],
          elevation: 6.0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: GoogleFonts.ubuntuTextTheme()
                .button
                ?.copyWith(fontWeight: FontWeight.w700),
            primary: Colors.blue[900],
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: GoogleFonts.ubuntuTextTheme()
                .button
                ?.copyWith(fontWeight: FontWeight.w700),
            primary: Colors.blue[900],
          ),
        ),
        textTheme: GoogleFonts.ubuntuTextTheme().apply(
          bodyColor: Colors.blue[900],
          displayColor: Colors.blue[900],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blue[900],
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.blue[900],
          ),
          titleTextStyle: GoogleFonts.ubuntuTextTheme().headline5?.copyWith(
                color: Colors.blue.shade900,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          selectedIconTheme: IconThemeData(color: Colors.blue.shade900, size: 32),
          selectedItemColor: Colors.blue[900],
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 24),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
        ),
      );

  static TextStyle? textFieldHeaderStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontWeight: FontWeight.w700);
  }

  static OutlineInputBorder? textOutlineFocusedBorder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static UnderlineInputBorder? textUnderlineFocusedBorder(
      BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return UnderlineInputBorder(
      borderSide: BorderSide(width: 2, color: primaryColor),
      // borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineEnabledBorder(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static UnderlineInputBorder? textUnderlineEnabledBorder(
      BuildContext context) {
    final primaryColor = Theme.of(context).primaryColorDark;
    return UnderlineInputBorder(
      borderSide: BorderSide(width: 2, color: primaryColor),
      // borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineErrorBorder(BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return OutlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static UnderlineInputBorder? textUnderlineErrorBorder(BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return UnderlineInputBorder(
      borderSide: BorderSide(color: errorColor),
      // borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static OutlineInputBorder? textOutlineErrorFocusedBorder(
      BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: errorColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }

  static UnderlineInputBorder? textUnderlineErrorFocusedBorder(
      BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    return UnderlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: errorColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    );
  }
}
