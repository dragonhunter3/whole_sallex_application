import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/theme/color_schem.dart';
import 'package:whole_selle_x_application/src/theme/text_them.dart';

class AppTheme {
  AppTheme._();

  factory AppTheme() {
    return instance;
  }

  static final AppTheme instance = AppTheme._();
  ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorSchemeLight,
      textTheme: appTextTheme(context),
    );
  }
}
