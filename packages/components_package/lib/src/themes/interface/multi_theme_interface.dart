import 'package:components_package/src/themes/app_font.dart';
import 'package:components_package/src/themes/app_theme.dart';
import 'package:components_package/src/themes/base_theme.dart';
import 'package:components_package/src/themes/colors/app_color.dart';
import 'package:flutter/material.dart';

abstract interface class MultiThemes {
  AppLightTheme get lightTheme;

  AppDarkTheme get darkTheme;

  ThemeMode get themeMode;

  AppColor get appColor;

  AppFont get appFont;

  BaseTheme<AppThemeOptions> get currentTheme;

  Future<void> changeTheme(ThemeMode mode);
}
