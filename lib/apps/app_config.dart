import 'package:flutter/material.dart';

final class AppConfig {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
