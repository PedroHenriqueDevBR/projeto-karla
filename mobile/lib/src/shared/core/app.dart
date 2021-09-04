import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_karla/src/pages/home/home_page.dart';
import 'package:projeto_karla/src/pages/login/login_page.dart';
import 'package:projeto_karla/src/pages/register_user/register_user_page.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_page.dart';
import 'package:projeto_karla/src/shared/core/app_themes.dart';
import 'package:asuka/asuka.dart' as asuka;

class App extends StatelessWidget {
  final _appThemes = AppThemes();
  App({Key? key}) : super(key: key);

  void changeNavigatorColor() {
    final uiOverlay = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.black,
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlay);
  }

  @override
  Widget build(BuildContext context) {
    changeNavigatorColor();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: asuka.builder,
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      initialRoute: '',
      routes: {
        '': (context) => LoginPage(),
        'register_user': (context) => RegisterUserPage(),
        'home': (context) => HomePage(),
        'event': (context) => ShowEventPage(),
      },
      title: 'Projeto Karla',
      theme: _appThemes.lightTheme,
      home: ShowEventPage(),
    );
  }
}
