import 'dart:io';
import 'package:device_package/device_package.dart' show SharingHelper;
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:permission_handler/permission_handler.dart';

/// A mixin that provides file management functionality.
///
/// This mixin offers methods to save files to the gallery with platform-specific handling.
/// It abstracts away the differences between iOS and Android for saving media files,
/// providing a unified interface.
mixin FileMixin {
  /// Saves a QR code image from raw bytes to the device gallery
  ///
  /// Handles platform-specific behavior:
  /// - On iOS: Opens the native sharing dialog (Photos, Files, etc.)
  /// - On Android: Directly saves to the gallery using Gal plugin
  ///
  /// Handles permissions and storage errors gracefully
  ///
  /// Parameters:
  /// - [bytes]: The raw image data as a Uint8List
  ///
  /// Returns true if successful, false if errors occur
  Future<bool> saveQRImageFromBytes(Uint8List bytes) async {
    try {
      if (Platform.isIOS) {
        // iOS uses system sharing dialog for better UX and permissions handling
        await SharingHelper.shareBytes(bytes, name: 'mission_qr_code');
      } else if (Platform.isAndroid) {
        // Android directly saves to gallery after permissions are granted
        await Gal.putImageBytes(bytes, name: 'mission_qr_code');
      }

      return true;
    } on GalException catch (e) {
      switch (e.type) {
        case GalExceptionType.accessDenied:
          // Open settings if permission denied so user can enable permissions
          await openAppSettings();
          break;
        case GalExceptionType.notEnoughSpace:
          // Call handler for not enough storage space
          notEnoughSpace();
          break;
        case GalExceptionType.notSupportedFormat:
        case GalExceptionType.unexpected:
          return false;
      }
      return false;
    }
  }

  /// Called when there is not enough space to save the file
  /// Implementing classes must provide this method to handle the error case
  void notEnoughSpace();
}
