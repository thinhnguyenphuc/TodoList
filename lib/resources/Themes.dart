import 'package:flutter/material.dart';

class Themes {
  static Color primaryColor = Colors.blueAccent.shade700;
  static ThemeData getThemeOf(ThemeName name) {
    switch (name) {
      case ThemeName.dark: {
        return darkTheme();
      }
      case ThemeName.light: {
        return lightTheme();
      }
    }
  }

  static ThemeData lightTheme() {




    return ThemeData(
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,

      primaryColor: primaryColor,
      primaryColorDark: Colors.black,
      primaryTextTheme: const TextTheme(
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
          )
      ),
      textTheme: const TextTheme(
        headline5: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        headline6: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        bodyText1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        subtitle1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        subtitle2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),

      hintColor: Colors.grey,

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),

      dividerColor: Colors.black,

      errorColor: Colors.red,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      canvasColor: Colors.black,
      primaryColor: primaryColor,
      backgroundColor: Colors.black,
      primaryTextTheme: const TextTheme(
          headline4: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.yellow.shade700,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}

enum ThemeName {
  light,
  dark,
}