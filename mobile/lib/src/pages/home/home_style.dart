import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/app_themes.dart';

class HomeStyle {
  AppThemes _appStyle = AppThemes();

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

  TextStyle get textStyleNothingToShow => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      );

  ButtonStyle get btnRefreshDataStyle => OutlinedButton.styleFrom(
        primary: _appStyle.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
}
