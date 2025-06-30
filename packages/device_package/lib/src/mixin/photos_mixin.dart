import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:device_package/device_package.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/// A mixin that provides photo-related functionality.
///
/// This mixin offers methods to request camera/photo permissions and pick images
/// from the gallery with various options for size validation and processing.
/// 
/// Classes implementing this mixin can easily add photo selection capabilities
/// with built-in permission handling and size validation.
mixin PhotoMixin {
  /// Singleton instance to track media state across the application
  final _mediaState = MediaState.instance;

  /// Requests permission to access the device's camera
  ///
  /// Returns a [Status] enum indicating the result of the permission request
  Future<Status> requestCameraPermission() async {
    final status = await DevicePermissionHandler.requestCamera();
    return switch (status) {
      PermissionStatus.denied => Status.denied,
      PermissionStatus.granted => Status.granted,
      PermissionStatus.restricted => Status.restricted,
      PermissionStatus.limited => Status.limited,
      PermissionStatus.permanentlyDenied => Status.permanentlyDenied,
      PermissionStatus.provisional => Status.provisional,
    };
  }

  /// Requests permission to access the device's photo library
  ///
  /// Returns a [Status] enum indicating the result of the permission request
  Future<Status> requestPhotoPermission() async {
    final status = await DevicePermissionHandler.requestPhoto();
    return switch (status) {
      PermissionStatus.denied => Status.denied,
      PermissionStatus.granted => Status.granted,
      PermissionStatus.restricted => Status.restricted,
      PermissionStatus.limited => Status.limited,
      PermissionStatus.permanentlyDenied => Status.permanentlyDenied,
      PermissionStatus.provisional => Status.provisional,
    };
  }

  /// Picks an image from the gallery with automatic permission handling
  ///
  /// Uses ImagePicker with optimized settings (1080px max dimensions, 80% quality)
  /// Handles permission checking automatically
  ///
  /// Returns the selected image as a File object, or null if selection was canceled
  Future<File?> pickImageFromGallery() async {
    await _checkStatusPermission();
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    );
    if (photo != null) {
      final file = File.fromUri(Uri.file(photo.path));
      final fileSize = await file.readAsBytes();
      debugPrint('File Path: ${photo.path}');
      debugPrint('file size ${fileSize.length}');
      return file;
    }

    return null;
  }

  /// Picks an image from the gallery specifically for QR code scanning
  ///
  /// Handles iOS-specific image format conversion (PNG to JPG) for better QR scanning
  /// Updates media state during processing
  ///
  /// Returns the selected image as a File object, or null if selection was canceled
  Future<File?> pickImageFromGalleryToScanQR() async {
    final status = await requestPhotoPermission();
    if (status == Status.permanentlyDenied) {
      await openAppSettings();
    }
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if (photo != null) {
      // Convert PNG to JPG for iOS devices to improve QR code scanning compatibility
      if (Platform.isIOS && photo.path.toLowerCase().endsWith('.png')) {
        final img = await decodePngFile(photo.path);
        await encodeJpgFile(photo.path, img!);
      }
      _mediaState.updateMediaState(MediaStateType.calculatingLength);
      final file = File.fromUri(Uri.file(photo.path));
      final fileSize = await file.readAsBytes();
      debugPrint('File Path: ${photo.path}');
      debugPrint('file size ${fileSize.length}');

      _mediaState.updateMediaState(MediaStateType.successful);
      return file;
    }

    return null;
  }

  /// Picks a photo from the gallery with size validation
  ///
  /// Uses FilePicker for more control over image selection
  /// Validates file size against maximum allowed size
  /// Updates media state during processing
  ///
  /// Parameters:
  /// - [maxSizeOfKB]: Maximum allowed size in kilobytes (default: 500KB)
  ///
  /// Returns a [PhotoPickerResult] with file details if successful,
  /// or null if validation failed or selection was canceled
  Future<PhotoPickerResult?> pickPhotoFromGallery({
    int maxSizeOfKB = 500,
  }) async {
    await _checkStatusPermission();
    final picker = FilePicker.platform;
    final photo = await picker.pickFiles(
      type: FileType.image,
      compressionQuality: 60,
    );
    if (photo != null && photo.files.isNotEmpty) {
      _mediaState.updateMediaState(MediaStateType.calculatingLength);
      final isValidSize = photo.files.first.size <= (1024 * maxSizeOfKB);
      if (!isValidSize) {
        // Compression code commented out - would be used to reduce file size if needed
        // final file = await FileUtils.compressAndGetFile(photo.files.first);
        await Future<void>.delayed(const Duration(seconds: 1));
        _mediaState.updateMediaState(MediaStateType.successful);
        // return PhotoPickerResult(
        //   name: file.name,
        //   path: file.path,
        //   size: file.size,
        //   bytes: file.bytes,
        // );
        onExceedingPermittedLimitsSize();
        return null;
      }

      _mediaState.updateMediaState(MediaStateType.successful);

      final file = photo.files.first;

      return PhotoPickerResult(
        name: file.name,
        path: file.path,
        size: file.size,
        bytes: file.bytes,
      );
    }

    return null;
  }

  /// Picks multiple photos from the gallery with size validation
  ///
  /// Allows selecting multiple images at once with total size validation
  /// Filters out non-image files (only allows jpg, jpeg, png)
  ///
  /// Parameters:
  /// - [maxFileSelection]: Maximum number of files to select (default: 1)
  /// - [maximumTotalSizeOfMb]: Maximum total size in MB per file (default: 5MB)
  ///
  /// Returns a list of [PhotoPickerResult] with file details,
  /// or empty list if validation failed or selection was canceled
  Future<List<PhotoPickerResult>> pickMultiplePhotoFromGallery({
    int maxFileSelection = 1,
    int maximumTotalSizeOfMb = 5,
  }) async {
    await _checkStatusPermission();

    final picker = FilePicker.platform;
    final photos = <PlatformFile>[];

    final photo = await picker.pickFiles(
      type: FileType.image,
      compressionQuality: 60,
      allowMultiple: true,
    );

    if (photo != null) {
      // Filter out non-image files
      photo.files.removeWhere(
        (element) =>
            ['jpg', 'jpeg', 'png'].contains(element.extension) == false,
      );
      photos.addAll(photo.files);

      if (photos.isNotEmpty) {
        _mediaState.updateMediaState(MediaStateType.calculatingLength);
        var totalLength = 0;
        final files = photos.take(maxFileSelection).toList();
        await Future.forEach(files, (element) async {
          final fileLength = element.size;
          return totalLength += fileLength;
        });

        // Check if total size is within limits
        final isValidSize =
            totalLength <=
            (maximumTotalSizeOfMb * 1024 * 1024 * maxFileSelection);
        _mediaState.updateMediaState(MediaStateType.successful);
        if (!isValidSize) {
          onExceedingPermittedLimitsSize();
          return [];
        }

        return files
            .map(
              (e) => PhotoPickerResult(
                name: e.name,
                path: e.path,
                size: e.size,
                bytes: e.bytes,
              ),
            )
            .toList();
      }
    }

    return [];
  }

  /// Converts a File to an Image object for processing
  ///
  /// Reads a file and decodes it to an image object for manipulation
  /// Adds a delay to avoid UI blocking
  ///
  /// Returns the decoded Image object, or null if conversion fails
  Future<img.Image?> fileToImage(File file) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final capturedImage = img.decodeImage(file.readAsBytesSync());

    return capturedImage;
  }

  /// Saves an Image object to a file in the temporary directory
  ///
  /// Encodes the image as PNG and saves to the temp directory
  /// Also logs the file size
  ///
  /// Returns a File object pointing to the saved image
  Future<File> imageToFileFromUnknownPath(img.Image image) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File(
      '${tempDir.path}/avatar.png',
    ).writeAsBytes(img.encodePng(image));
    unawaited(file.length().then(_getFileSize));
    return file;
  }

  /// Utility method to format file size in human-readable format (B, KB, MB, etc)
  void _getFileSize(int fileLength) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = (log(fileLength) / log(1024)).floor();
    final size =
        '${(fileLength / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
    // ignore: avoid_print
    print('file size $size');
  }

  /// Checks permission status and throws an exception if denied
  ///
  /// Attempts to open settings if permission is permanently denied
  /// Throws DeniedPermission exception if permission is still denied
  Future<void> _checkStatusPermission() async {
    final status = await requestPhotoPermission();
    if (status == Status.permanentlyDenied || status == Status.denied) {
      await openAppSettings();
    }
    throwIf(
      status == Status.denied || status == Status.permanentlyDenied,
      DeniedPermission(),
    );
  }

  /// Called when the selected photo exceeds the permitted size limit
  /// Implementing classes must provide this method
  void onExceedingPermittedLimitsSize();
}

/// Exception thrown when permission is denied
final class DeniedPermission extends IOException {}

/// Exception thrown when file size exceeds limits
final class ExceedingPermittedLimitsSize extends IOException {}

/// Data model representing a selected photo with its details
final class PhotoPickerResult {
  /// Original filename of the photo
  final String name;

  /// File path to the photo on device
  final String? path;

  /// Size of the photo file in bytes
  final int size;

  /// Raw bytes of the photo (optional)
  final Uint8List? bytes;

  /// Creates a new photo picker result with the specified details
  PhotoPickerResult({
    required this.name,
    required this.path,
    required this.size,
    this.bytes,
  });
}
