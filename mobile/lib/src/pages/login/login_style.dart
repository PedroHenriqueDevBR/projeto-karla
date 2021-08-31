import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';

class LoginStyle {
  AppAssets _appAssets = AppAssets();

  BoxDecoration get backgroundContainer => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_appAssets.background),
          fit: BoxFit.cover,
        ),
      );
}
