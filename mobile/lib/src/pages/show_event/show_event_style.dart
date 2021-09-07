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

  BoxDecoration get backButtonStyle => BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black.withAlpha(100),
      );

  BoxDecoration get bottomSheetStyle => BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      );

  BoxDecoration cardHeaderDecoration({required String image, bool isNetwork = false}) {
    return BoxDecoration(
      image: isNetwork
          ? DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            )
          : DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
    );
  }
}
