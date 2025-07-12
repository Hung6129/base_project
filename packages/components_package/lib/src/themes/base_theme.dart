import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

base class BaseTheme<T extends ThemeOptions> {
  /// Setting the status bar color to transparent.
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  /// A property of the BaseTheme class.
  final ThemeData data;

  /// A way to pass in an optional class that can be used to customize the theme.
  final T? options;

  const BaseTheme({
    required this.data,
    this.options,
    this.systemUiOverlayStyle,
  });

  /// `BaseTheme.light()` returns a new instance of `BaseTheme` with a `ThemeData`
  /// object that has a light theme and a `SystemUiOverlayStyle` object that has a
  /// transparent navigation bar and status bar
  ///
  /// Returns:
  ///   A new instance of the BaseTheme class.
  factory BaseTheme.light() {
    return BaseTheme(
      data: ThemeData.light(),
      systemUiOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  /// `BaseTheme.dark()` returns a new `BaseTheme` object with a `ThemeData` object
  /// that is dark, and a `SystemUiOverlayStyle` object that is transparent
  ///
  /// Returns:
  ///   A new instance of the BaseTheme class.
  factory BaseTheme.dark() {
    return BaseTheme(
      data: ThemeData.dark(),
      systemUiOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}

/// Interface to use when creating an app theme option class.
abstract class ThemeOptions {}
