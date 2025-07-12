import 'package:base_project/apps/di/app_config.dart';
import 'package:base_project/apps/routes/app_routes.dart';
import 'package:components_package/components_package.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // AppState get appState => AppScope.of<AppState>(this);

  // AppThemeOptions get appTheme => appState.currentTheme.options!;

  // AppColor get color => appState.appColor;

  // AppFont get font => appState.appFont;

  AppRoutes get appRoutes => getIt<AppRoutes>();

  EdgeInsets get padding => MediaQuery.of(this).padding;

  double get bottom => MediaQuery.of(this).padding.bottom;

  void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();
}
