import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_package/src/basic_info/android_device_id.dart'
    show AndroidDeviceId;
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Helper class to retrieve device and application information
class DeviceHelper {
  /// Returns the name of the operating system (e.g., "android", "ios")
  static String getOS() => Platform.operatingSystem;

  /// Returns the OS version string (e.g., "10.0.0")
  static String getOSVersion() => Platform.operatingSystemVersion;

  /// Returns the device locale (e.g., "en_US")
  static String getLanguage() => Platform.localeName;

  /// Returns the application version (e.g., "1.0.0")
  static String getAppVersion() => GetIt.I<PackageInfo>().version;

  /// Returns the application build number (e.g., "100")
  static String getBuildVersion() => GetIt.I<PackageInfo>().buildNumber;

  /// Returns the device's unique identifier
  ///
  /// For Android: Uses AndroidDeviceId
  /// For iOS: Uses identifierForVendor
  static String getDeviceId() {
    if (Platform.isAndroid) {
      final deviceInfo = GetIt.I<AndroidDeviceId>();
      return deviceInfo.deviceId ?? '';
    } else if (Platform.isIOS) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as IosDeviceInfo;
      return deviceInfo.identifierForVendor ?? '';
    }
    return '';
  }

  /// Returns the Android SDK version (API level)
  /// Returns -1 for non-Android platforms
  static int getAndroidVersionSDK() {
    if (Platform.isAndroid) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as AndroidDeviceInfo;
      return deviceInfo.version.sdkInt;
    }
    return -1;
  }

  /// Returns the device manufacturer name
  ///
  /// For Android: Returns the actual manufacturer (e.g., "Samsung", "Xiaomi")
  /// For iOS: Returns "Apple"
  static String getMobileBrandName() {
    if (Platform.isAndroid) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as AndroidDeviceInfo;
      return deviceInfo.manufacturer;
    } else if (Platform.isIOS) {
      return 'Apple';
    }
    return '';
  }

  /// Checks if the app is running on a physical device or an emulator/simulator
  static bool isPhysicalDevice() {
    if (Platform.isAndroid) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as AndroidDeviceInfo;
      return deviceInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as IosDeviceInfo;
      return deviceInfo.isPhysicalDevice;
    }
    return false;
  }

  /// Returns the device model name (e.g., "iPhone X", "Pixel 6")
  static String getMobileModelName() {
    if (Platform.isAndroid) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as AndroidDeviceInfo;
      return deviceInfo.model;
    } else if (Platform.isIOS) {
      final deviceInfo = GetIt.I<BaseDeviceInfo>() as IosDeviceInfo;
      return deviceInfo.model;
    }
    return '';
  }

  /// Legacy method for advertising tracking status
  /// Currently always returns false
  static bool getIsLimitedAdTracking() {
    return false;
  }

  /// Returns the platform name in a user-friendly format
  ///
  /// e.g., "Android", "IOS", "MacOS", etc.
  static String getPlatform() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else if (Platform.isMacOS) {
      return 'MacOS';
    } else if (Platform.isFuchsia) {
      return 'Fuchsia';
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isLinux) {
      return 'Linux';
    }
    return '';
  }

  /// Returns the application's package name (bundle identifier)
  static String getPackageName() {
    return GetIt.I<PackageInfo>().packageName;
  }
}
