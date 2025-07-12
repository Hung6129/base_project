import 'package:components_package/src/themes/app_font_weight.dart';
import 'package:flutter/material.dart';

abstract base class AppFont {
  final String fontFamily;

  AppFont(this.fontFamily);

  TextStyle get hero1;

  TextStyle get hero2;

  TextStyle get hero3;

  TextStyle get h1;

  TextStyle get h2;

  TextStyle get h3;

  TextStyle get h4;

  TextStyle get h5;

  TextStyle get bodyBoldM;

  TextStyle get bodyBoldL;

  TextStyle get bodyBoldS;

  TextStyle get bodyM;

  TextStyle get bodyS;

  TextStyle get baseM;

  TextStyle get baseS;

  TextStyle get baseL;

  TextStyle get titleL;

  TextStyle get captionM;

  TextStyle get captionS;

  TextStyle get captionRegularS;

  TextStyle get buttonM;

  TextStyle get buttonS;

  TextStyle get buttonL;

  /// Material 3 theme

  TextStyle get displayLarge; // headline1
  TextStyle get displayMedium; // headline2
  TextStyle get displaySmall; // headline3
  TextStyle get headlineMedium; //headline4
  TextStyle get headlineSmall; //headline5
  TextStyle get titleLarge; //headline6
  TextStyle get titleMedium; //subtitle1
  TextStyle get titleSmall; // subtitle2
  TextStyle get bodyLarge; // bodyText1
  TextStyle get bodyMedium; // bodyText2
  TextStyle get bodySmall; // caption
  TextStyle get labelLarge; // button
  TextStyle get labelSmall; // overline

  TextStyle get headlineLarge;
}

final class RobotoMono extends AppFont {
  RobotoMono() : super('packages/components_module/RobotoMono');

  @override
  TextStyle get captionM => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
  );

  @override
  TextStyle get captionRegularS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
  );

  @override
  TextStyle get captionS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: AppFontWeight.medium,
  );

  @override
  TextStyle get baseL => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get baseM => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get baseS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get bodyBoldM => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get bodyBoldS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get bodyM => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: AppFontWeight.regular,
  );

  @override
  TextStyle get bodyS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
  );

  @override
  TextStyle get buttonL => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get buttonM => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get buttonS => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get h1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 64,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get h2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get h3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get h4 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get h5 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get hero1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 104,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get hero2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 96,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get hero3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 80,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get titleL => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: AppFontWeight.bold,
  );

  @override
  TextStyle get bodyLarge => baseL;

  @override
  TextStyle get bodyMedium => bodyM;

  @override
  TextStyle get bodySmall => bodyS;

  @override
  TextStyle get displayLarge => h1;

  @override
  TextStyle get displayMedium => h2;

  @override
  TextStyle get displaySmall => h3;

  @override
  TextStyle get headlineMedium => h4;

  @override
  TextStyle get headlineSmall => h5;

  @override
  TextStyle get labelLarge => captionM;

  @override
  TextStyle get labelSmall => captionS;

  @override
  TextStyle get titleLarge => titleL;

  @override
  TextStyle get titleMedium => titleL;

  @override
  TextStyle get titleSmall => titleL;

  @override
  TextStyle get headlineLarge => h3;

  @override
  TextStyle get bodyBoldL => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
  );
}
