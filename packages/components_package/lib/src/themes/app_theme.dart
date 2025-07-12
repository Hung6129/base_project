import 'package:components_package/src/themes/app_font.dart';
import 'package:components_package/src/themes/base_theme.dart';
import 'package:components_package/src/themes/colors/app_color.dart';
import 'package:components_package/src/themes/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
final class ThemeManager {
  final AppDarkTheme _appDarkTheme;

  final AppLightTheme _appLightTheme;

  ThemeMode? _themeMode;

  ThemeManager(this._appDarkTheme, this._appLightTheme);

  AppLightTheme get baseLightTheme => _appLightTheme;

  AppDarkTheme get baseDarkTheme => _appDarkTheme;

  ThemeMode get themeMode => _themeMode ?? ThemeMode.light;

  BaseTheme<AppThemeOptions> get currentTheme {
    if (themeMode == ThemeMode.dark) return baseDarkTheme;

    return baseLightTheme;
  }

  void changeThemeMode(ThemeMode themeMode) => _themeMode = themeMode;
}

@LazySingleton()
final class AppLightTheme extends BaseTheme<LightThemeOptions> {
  AppLightTheme(LightThemeOptions options)
    : super(
        data: ThemeData(
          fontFamily: options.font.fontFamily,
          textTheme: options.textTheme,
          appBarTheme: options.appBarTheme,
          bottomNavigationBarTheme: options.bottomNavBar,
          // colorScheme: options.colorScheme,
          textButtonTheme: options.textButtonTheme,
          elevatedButtonTheme: options.elevatedButtonTheme,
          outlinedButtonTheme: options.outlinedButtonTheme,
          splashColor: options.color.neutral.one,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: options.color.neutral.seven,
            selectionColor: options.color.neutral.three,
            selectionHandleColor: options.color.neutral.seven,
          ),
          dividerTheme: const DividerThemeData(space: 16, thickness: 1),
        ),
        options: options,
      );
}

@LazySingleton()
final class AppDarkTheme extends BaseTheme<DarkThemeOptions> {
  AppDarkTheme(DarkThemeOptions options)
    : super(
        data: ThemeData(
          // snackBarTheme: SnackBarThemeData(
          //   backgroundColor: options.color.neutral.light,
          //   contentTextStyle: options.font.titleMedium,
          // ),
          fontFamily: options.font.fontFamily,
          textTheme: options.textTheme,
          // appBarTheme: options.appBarTheme,
          bottomNavigationBarTheme: options.bottomNavBar,
          // textButtonTheme: options.textButtonTheme,
          // elevatedButtonTheme: options.elevatedButtonTheme,
          // inputDecorationTheme: options.inputDecorationTheme,
          // primaryColor: options.color.primary.primary,
          // dividerColor: options.color.content.light,
        ),
        options: options,
      );
}

@LazySingleton()
class LightThemeOptions extends AppThemeOptions {
  @override
  AppFont get font => RobotoMono();

  @override
  AppColor get color => LightAppColor();

  @override
  TextTheme get textTheme => TextTheme(
    displayLarge: font.displayLarge,
    displayMedium: font.displaySmall,
    displaySmall: font.displaySmall,
    headlineLarge: font.headlineLarge,
    headlineMedium: font.headlineMedium,
    headlineSmall: font.headlineSmall,
    titleLarge: font.titleLarge,
    titleMedium: font.titleMedium,
    titleSmall: font.titleSmall,
    bodyLarge: font.bodyLarge,
    bodyMedium: font.bodyMedium,
    bodySmall: font.bodySmall,
    labelLarge: font.buttonL,
    labelMedium: font.buttonM,
    labelSmall: font.buttonS,
  );

  @override
  BaseAppDimens get dimens => AppDimens();

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    toolbarHeight: dimens.toolbarHeight,
    elevation: dimens.toolbarElevation,
    centerTitle: true,
    titleTextStyle: font.titleL,
  );

  @override
  BottomNavigationBarThemeData get bottomNavBar => BottomNavigationBarThemeData(
    backgroundColor: color.neutral.zero,
    selectedItemColor: color.error.five,
    unselectedItemColor: color.neutral.three,
    selectedIconTheme: IconThemeData(
      size: dimens.bottomNavBarIconSize,
      color: color.error.five,
    ),
    unselectedIconTheme: IconThemeData(
      size: dimens.bottomNavBarIconSize,
      color: color.neutral.three,
    ),
    type: BottomNavigationBarType.fixed,
    elevation: dimens.bottomNavBarElevation,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedLabelStyle: font.bodyBoldM.copyWith(color: color.error.five),
    unselectedLabelStyle: font.bodyBoldM.copyWith(color: Colors.transparent),
  );

  //
  // @override
  // ColorScheme get colorScheme => ColorScheme(
  //     // background: color.neutral.light,
  //     brightness: Brightness.light,
  //     // primary: color.primary.primary,
  //     // // onPrimary: color.primary.second,
  //     // secondary: color.secondary.primary,
  //     // onSecondary: color.secondary.second,
  //     // error: color.status.errorMedium,
  //     // onError: color.status.errorLight,
  //     // onBackground: color.neutral.dark,
  //     // surface: color.other.medium,
  //     // onSurface: color.other.light
  // );
  //
  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        } else if (states.contains(WidgetState.pressed)) {
          return color.neutral.seven;
        }
        return color.neutral.four;
      }),
      overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
    ),
  );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      minimumSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeightS),
      ),
      maximumSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeightL),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.buttonRadius),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.two;
        } else if (states.contains(WidgetState.pressed)) {
          return color.primary.six;
        }
        return color.primary.five;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(font.buttonL),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        }
        return color.neutral.zero;
      }),
      overlayColor: WidgetStateProperty.all(color.neutral.one.withOpacity(0.1)),
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      fixedSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeight),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(font.buttonL),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.buttonRadius),
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        return BorderSide(color: color.neutral.three);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        }
        return color.neutral.seven;
      }),
      overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
    ),
  );

  @override
  TabBarTheme get tabBarTheme => TabBarTheme(
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: color.primary.four, width: 2)),
    ),
    labelColor: color.primary.four,
    unselectedLabelColor: color.neutral.three,
    indicatorSize: TabBarIndicatorSize.label,
  );

  // @override
  // InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
  //       errorBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.primary.primary),
  //       ),
  //       focusedErrorBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.primary.primary),
  //       ),
  //       border: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.content.light),
  //       ),
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.content.light),
  //       ),
  //       enabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.content.light),
  //       ),
  //       disabledBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: color.content.medium),
  //       ),
  //       hintStyle: font.bodyM.apply(color: color.content.veryDark),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     );
  //
  // @override
  // BoxShadow get boxShadow => BoxShadow(
  //       offset: const Offset(0, 6),
  //       color: color.neutral.dark.withOpacity(0.06),
  //       blurRadius: 6,
  //     );
  //

  //
  // DatePickerThemeData get datePickerTheme => DatePickerThemeData(
  //       backgroundColor: color.neutral.light,
  //       headerBackgroundColor: color.neutral.light,
  //       rangePickerBackgroundColor: color.neutral.light,
  //       dayBackgroundColor: WidgetStateProperty.all(color.neutral.light),
  //       yearBackgroundColor: WidgetStateProperty.all(color.neutral.light),
  //     );
}

@LazySingleton()
class DarkThemeOptions extends AppThemeOptions {
  @override
  BaseAppDimens get dimens => AppDimens();

  @override
  AppColor get color => DarkAppColor();

  @override
  TextTheme get textTheme => TextTheme(
    displayLarge: font.h1,
    displayMedium: font.h2,
    displaySmall: font.h3,
    headlineLarge: font.h4,
    headlineMedium: font.h5,
    headlineSmall: font.titleL,
  );

  @override
  AppFont get font => RobotoMono();

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
    toolbarHeight: dimens.toolbarHeight,
    elevation: dimens.toolbarElevation,
    centerTitle: true,
    titleTextStyle: font.titleL,
  );

  @override
  BottomNavigationBarThemeData get bottomNavBar => BottomNavigationBarThemeData(
    backgroundColor: color.neutral.one,
    selectedItemColor: color.error.five,
    unselectedItemColor: color.neutral.three,
    selectedIconTheme: IconThemeData(size: dimens.bottomNavBarIconSize),
    unselectedIconTheme: IconThemeData(size: dimens.bottomNavBarIconSize),
    type: BottomNavigationBarType.fixed,
    elevation: dimens.bottomNavBarElevation,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedLabelStyle: font.bodyBoldM.copyWith(color: color.error.five),
    unselectedLabelStyle: font.bodyBoldM.copyWith(color: Colors.transparent),
  );

  //
  // @override
  // ColorScheme get colorScheme => ColorScheme(
  //     background: color.neutral.light,
  //     brightness: Brightness.light,
  //     primary: color.primary.primary,
  //     onPrimary: color.primary.second,
  //     secondary: color.secondary.primary,
  //     onSecondary: color.secondary.second,
  //     error: color.status.errorMedium,
  //     onError: color.status.errorLight,
  //     onBackground: color.neutral.dark,
  //     surface: color.other.medium,
  //     onSurface: color.other.light);
  //
  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        } else if (states.contains(WidgetState.pressed)) {
          return color.neutral.seven;
        }
        return color.neutral.four;
      }),
    ),
  );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      minimumSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeightS),
      ),
      maximumSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeightL),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.buttonRadius),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.two;
        } else if (states.contains(WidgetState.pressed)) {
          return color.primary.six;
        }
        return color.primary.five;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(font.buttonL),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        }
        return color.neutral.zero;
      }),
    ),
  );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(dimens.buttonElevation),
      fixedSize: WidgetStateProperty.all<Size>(
        Size.fromHeight(dimens.buttonHeight),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(font.buttonL),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimens.buttonRadius),
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        return BorderSide(color: color.neutral.three);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return color.neutral.three;
        }
        return color.neutral.zero;
      }),
    ),
  );

  @override
  TabBarTheme get tabBarTheme =>
      TabBarTheme(indicator: BoxDecoration(color: color.primary.four));

  // @override
  // InputDecorationTheme get inputDecorationTheme => const InputDecorationTheme();
}

abstract class AppThemeOptions extends ThemeOptions {
  AppColor get color;

  AppFont get font;

  BaseAppDimens get dimens;

  TextTheme get textTheme;

  TabBarTheme get tabBarTheme;

  AppBarTheme get appBarTheme;

  // ColorScheme get colorScheme;
  //
  //
  BottomNavigationBarThemeData get bottomNavBar;

  //
  TextButtonThemeData get textButtonTheme;

  ElevatedButtonThemeData get elevatedButtonTheme;

  OutlinedButtonThemeData get outlinedButtonTheme;
  //
  // InputDecorationTheme get inputDecorationTheme;
}
