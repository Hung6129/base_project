import 'package:flutter/material.dart';

final class AppScope<T extends BaseAppState> extends InheritedNotifier<T> {
  const AppScope({super.key, required super.child, required T super.notifier});

  static T of<T extends BaseAppState>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScope<T>>()!.notifier!;
  }
}

abstract base class BaseAppState extends ChangeNotifier {
  BaseAppState() {
    init();
  }

  bool _initialized = false;

  bool get initialized => _initialized;

  Future<void> init() async {
    await initAppState();
    if (!_initialized) {
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> initAppState();
}
