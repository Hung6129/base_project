import 'package:screen_brightness/screen_brightness.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Helper class for interacting with device hardware features
final class DeviceHardwareHelper {
  /// Prevents the device screen from turning off (keeps the screen awake)
  static Future<void> wakeLockEnable() {
    return WakelockPlus.enable();
  }

  /// Allows the device screen to turn off based on system settings
  static Future<void> wakeLockDisable() {
    return WakelockPlus.disable();
  }

  /// Sets screen brightness to a specific level
  ///
  /// [brightness] - Value between 0.0 (darkest) and 1.0 (brightest)
  static Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(brightness);
    } catch (e) {
      // Handle error
    }
  }

  /// Resets screen brightness to system default/auto value
  static Future<void> resetBrightness() async {
    try {
      await ScreenBrightness().resetApplicationScreenBrightness();
    } catch (e) {
      // Handle error
    }
  }

  /// Triggers device vibration with default duration and amplitude
  static Future<void> vibrate() {
    return Vibration.vibrate();
  }
}
