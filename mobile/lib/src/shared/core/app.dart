import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/login/login_page.dart';
import 'package:projeto_karla/src/shared/core/app_themes.dart';
import 'package:asuka/asuka.dart' as asuka;

class App extends StatelessWidget {
  final _appThemes = AppThemes();
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      title: 'Projeto Karla',
      theme: _appThemes.lightTheme,
      home: LoginPage(),
    );
  }
}
