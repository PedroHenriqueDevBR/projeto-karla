import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/app_themes.dart';

class ShowEventStyle {
  final _appThemes = AppThemes();
  ButtonStyle get bottomButtonStyle => ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 8.0,
        ),
        primary: _appThemes.secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(),
      );

  BoxDecoration get iconButtonStyle => BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _appThemes.primaryColor,
      );
}
