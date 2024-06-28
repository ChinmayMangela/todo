import 'package:flutter/material.dart';

class AppTheme {

  static _getCheckBoxThemeData(bool isDarkMode) {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all(
        isDarkMode ? Colors.black : Colors.white,
      ),
    );
  }

  static _getFloatingActionThemeData(bool isDarkMode) {
    return FloatingActionButtonThemeData(
      backgroundColor: isDarkMode ? Colors.white : Colors.black,
      foregroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }

  static _getAppBarTheme() {
    return const AppBarTheme(
      color: Colors.transparent,
    );
  }

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade200,
    cardColor: Colors.white,
    appBarTheme: _getAppBarTheme(),
    checkboxTheme: _getCheckBoxThemeData(false),
    floatingActionButtonTheme: _getFloatingActionThemeData(false),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey.shade700,
    appBarTheme: _getAppBarTheme(),
    checkboxTheme: _getCheckBoxThemeData(true),
    floatingActionButtonTheme: _getFloatingActionThemeData(true),
  );
}
