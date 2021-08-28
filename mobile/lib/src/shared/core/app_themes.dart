import 'package:flutter/material.dart';

class AppThemes {
  Color primaryColor = Color(0XFFD81B60);
  Color secondaryColor = Color(0XFF834790);
  TextTheme _defaulttextTheme = TextTheme();

  ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        elevatedButtonTheme: _elevatedButtonThemeData,
        inputDecorationTheme: _inputDecorationTheme,
        appBarTheme: _appBarTheme,
        floatingActionButtonTheme: _fabTheme,
        bottomNavigationBarTheme: _bottomNavigationTheme,
      );

  AppBarTheme get _appBarTheme => AppBarTheme(elevation: 0);

  FloatingActionButtonThemeData get _fabTheme => FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        elevation: 4,
        foregroundColor: Colors.white,
      );

  ElevatedButtonThemeData get _elevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          primary: primaryColor,
        ),
      );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
        ),
      );

  BottomNavigationBarThemeData get _bottomNavigationTheme => BottomNavigationBarThemeData(
        backgroundColor: secondaryColor,
        elevation: 0,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      );
}
