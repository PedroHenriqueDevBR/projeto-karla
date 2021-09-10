import 'package:flutter/material.dart';
import '../../shared/core/assets.dart';

class RegisterUserStyle {
  AppAssets _appAssets = AppAssets();

  BoxDecoration get backgroundContainer => BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_appAssets.background),
          fit: BoxFit.cover,
        ),
      );
}
