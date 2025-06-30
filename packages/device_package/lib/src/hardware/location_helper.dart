import 'dart:io';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

export 'package:geolocator/geolocator.dart' show Position;

/// Helper class for location-related functionality
final class LocationHelper {
  /// Stream of position updates with platform-specific settings
  ///
  /// Android: Reduced accuracy with 100m distance filter and 5-minute intervals
  /// iOS: 100m distance filter with background updates disabled
  static Stream<Position> positionStream = Geolocator.getPositionStream(
    locationSettings: Platform.isAndroid
        ? AndroidSettings(
            accuracy: LocationAccuracy.reduced,
            distanceFilter: 100,
            intervalDuration: const Duration(minutes: 5),
          )
        : AppleSettings(
            distanceFilter: 100,
            allowBackgroundLocationUpdates: false,
          ),
  );

  /// Attempts to get the current device location with configurable parameters
  ///
  /// [desiredAccuracy] - Accuracy level for location data (default: medium)
  /// [timeout] - Maximum time to wait for location (default: 5 seconds)
  /// [useLastKnownLocation] - Whether to fall back to last known location (default: true)
  ///
  /// Returns a Position object if successful, or null if location services are disabled
  /// or if permission is denied
  static Future<Position?> determinePosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.medium,
    Duration timeout = const Duration(seconds: 5),
    bool useLastKnownLocation = true,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // Check if we have permission to access location
    permission = await Geolocator.checkPermission();
    if (![
      LocationPermission.whileInUse,
      LocationPermission.always,
    ].contains(permission)) {
      return null;
    }

    try {
      // Try to get current position with specified accuracy and timeout
      final currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
        timeLimit: timeout,
      );

      return currentLocation;
    } catch (e) {
      // Fall back to last known position if getting current position fails
      final lastKnownLocation = await Geolocator.getLastKnownPosition();
      if (lastKnownLocation != null) {
        return lastKnownLocation;
      }
    }
    return null;
  }

  /// Gets the name of the country at the current device location
  ///
  /// Handles permission requests if needed
  /// Returns the country name as a string if successful
  static Future<String?> getCountryName() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.',
        );
      }
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    var placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    var first = placeMarks.first;
    return first.country;
  }
}
