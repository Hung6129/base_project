import 'dart:io';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

/// A helper class that provides methods to share different types of content
/// using the device's native sharing capabilities.
///
/// This class wraps the share_plus package functionality for easier use.
final class SharingHelper {
  /// Shares plain text content using the platform's share dialog.
  ///
  /// [text] The content text to share.
  /// [title] Optional title/subject for the share dialog.
  ///
  /// Returns a Future that completes when the sharing operation is done.
  static Future<void> shareText(String text, {String? title}) {
    return Share.share(text, subject: title);
  }

  /// Shares a file from the device filesystem using the platform's share dialog.
  ///
  /// [file] The File object pointing to the file to be shared.
  /// [title] Optional title/subject for the share dialog.
  ///
  /// Returns a Future that completes when the sharing operation is done.
  /// The file is read into memory before sharing.
  static Future<void> shareFile(File file, {String? title}) {
    // Convert File to XFile which is required by the Share.shareXFiles method
    final xFile = XFile(file.path, bytes: file.readAsBytesSync());
    return Share.shareXFiles([xFile], subject: title);
  }

  /// Shares binary data (bytes) using the platform's share dialog.
  ///
  /// [bytes] The binary data to share.
  /// [title] Optional title/subject for the share dialog.
  /// [name] Optional filename to assign to the shared content.
  ///
  /// Returns a Future that completes when the sharing operation is done.
  /// The bytes are treated as PNG data by default.
  static Future<void> shareBytes(
    Uint8List bytes, {
    String? title,
    String? name,
  }) {
    // Create an XFile from binary data with PNG mime type
    final xFile = XFile.fromData(bytes, mimeType: 'png', name: name);
    return Share.shareXFiles([xFile], subject: title);
  }
}
