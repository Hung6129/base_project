import 'package:base_project/app.dart';
import 'package:base_project/apps/app_config.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

Future<void> main() async {
  try {
    await AppConfig.init();
  } catch (e) {
    if (kDebugMode) {
      print('Error during app initialization: $e');
    }
  }
  runApp(const App());
}
