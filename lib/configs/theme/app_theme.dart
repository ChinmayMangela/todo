import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static _getCheckBoxTheme(bool isDarkMode) {
    return CheckboxThemeData(
      checkColor: WidgetStateProperty.all(
        isDarkMode ? Colors.black : Colors.white,
      ),
    );
  }

  static _getFloatingActionTheme(bool isDarkMode) {
    return FloatingActionButtonThemeData(
      backgroundColor: isDarkMode ? Colors.white : Colors.black,
      foregroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }

  static _getDatePickerTheme(bool isDarkMode) {
    return DatePickerThemeData(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        todayForegroundColor: WidgetStateProperty.all(isDarkMode ? Colors.white : Colors.black),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return isDarkMode ? Colors.white : Colors.black;
          }
          return null; // Default background
        },),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if(states.contains(WidgetState.selected)) {
            return isDarkMode ? Colors.black : Colors.white;
          }
          return null;
        }),
    );

  }

  static _getElevatedButtonTheme(bool isDarkMode) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        foregroundColor: isDarkMode ? Colors.black : Colors.white,
      )
    );
  }

  static _getAppBarTheme() {
    return const AppBarTheme(
      color: Colors.transparent,
    );
  }

  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.latoTextTheme(),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: _getAppBarTheme(),
    checkboxTheme: _getCheckBoxTheme(false),
    floatingActionButtonTheme: _getFloatingActionTheme(false),
    datePickerTheme: _getDatePickerTheme(false),
    elevatedButtonTheme: _getElevatedButtonTheme(false),
  );

  static final darkTheme = ThemeData(
    textTheme: GoogleFonts.latoTextTheme(),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: _getAppBarTheme(),
    checkboxTheme: _getCheckBoxTheme(true),
    floatingActionButtonTheme: _getFloatingActionTheme(true),
    datePickerTheme: _getDatePickerTheme(true),
    elevatedButtonTheme: _getElevatedButtonTheme(true),
  );
}
