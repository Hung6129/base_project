import 'dart:io';

class KeyByPlatform<T> {
  final T android;
  final T iOS;
  final T? other;

  KeyByPlatform({required this.android, required this.iOS, this.other});

  T get key {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return iOS;
    } else if (other != null) {
      return other!;
    }
    throw UnsupportedError('Unsupported this platform: ${Platform.operatingSystem}');
  }
}
