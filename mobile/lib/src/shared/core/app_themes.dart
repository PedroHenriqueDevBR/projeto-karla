import 'package:flutter/material.dart';

class AppThemes {
  Color primaryColor = Color(0XFFD81B60);
  Color secondaryColor = Color(0XFF834790);

  ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.light().copyWith(
          primary: primaryColor,
          primaryVariant: primaryColor,
          secondary: secondaryColor,
          secondaryVariant: secondaryColor,
        ),
        textTheme: TextTheme(),
        brightness: Brightness.light,
        elevatedButtonTheme: _elevatedButtonThemeData,
        inputDecorationTheme: _inputDecorationTheme,
      );

  ElevatedButtonThemeData get _elevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        ),
      );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(),
      );
}
