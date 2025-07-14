import 'package:flutter/foundation.dart';

final class LoadingManager {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier(false);

  void show() => loadingNotifier.value = true;

  void hide() => loadingNotifier.value = false;

  void dispose() => loadingNotifier.dispose();
}
