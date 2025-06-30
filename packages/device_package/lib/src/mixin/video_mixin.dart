import 'dart:async';
import 'package:device_package/device_package.dart';
import 'package:file_picker/file_picker.dart';

/// A mixin that provides video selection and permission handling functionality.
///
/// This mixin enables classes to request video permissions and select videos
/// from the device gallery with size and file type validation.
mixin VideoMixin {
  /// Singleton instance to track media state across the application
  final _mediaState = MediaState.instance;

  /// Requests permission to access the device's photo/video library
  ///
  /// Returns a [Status] enum indicating the result of the permission request
  /// - [Status.granted] when user allows access
  /// - [Status.denied] when user denies access
  /// - [Status.permanentlyDenied] when user has previously denied and selected "never ask again"
  Future<Status> requestVideoPermission() async {
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

  /// Picks a video from the gallery with size and type validation
  ///
  /// Parameters:
  /// - [maxSizeOfMB]: Maximum allowed file size in megabytes (default: 10MB)
  /// - [mimeType]: Allowed video file types, comma-separated (default: 'mp4/mov')
  ///
  /// Returns a [VideoModel] if selection is successful and passes validation,
  /// or null if the selection was cancelled or fails validation
  Future<VideoModel?> getVideoFromGallery({
    int maxSizeOfMB = 10,
    String mimeType = 'mp4/mov',
  }) async {
    final picker = FilePicker.platform;
    final video = await picker.pickFiles(
      // source: ImageSource.gallery,
      // preferredCameraDevice: CameraDevice.front,
      // maxDuration: const Duration(seconds: 130),
      type: FileType.video,
    );

    // Check if file was selected and is not empty
    if (video != null && video.files.isNotEmpty == true) {
      // Extract file extension and validate against allowed mime types
      final videoType = video.files.first.name.split('.').last;
      if (!mimeType.contains(videoType.toLowerCase())) {
        onInvalidMimeType();
        return null;
      }

      // Update app state to show calculating size
      _mediaState.updateMediaState(MediaStateType.calculatingLength);

      final fileSize = video.files.first.size;

      // Simulate processing time
      await Future<void>.delayed(const Duration(seconds: 2));

      // Update state to show successful calculation
      _mediaState.updateMediaState(MediaStateType.successful);

      // Validate file size against maximum allowed
      if (fileSize > maxSizeOfMB * 1024 * 1024) {
        onExceedingPermittedLimitsSize();
        return null;
      } else {
        // Create and return video model with file details
        final videoModel = VideoModel(
          path: video.files.first.path!,
          fileName: video.files.first.name,
        );

        return videoModel;
      }
    }

    return null;
  }

  // Commented utility method for formatting file size
  // void _getFileSize(int fileLength) {
  //   const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  //   var i = (log(fileLength) / log(1024)).floor();
  //   final size =
  //       ((fileLength / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  //   print('file size $size');
  // }

  /// Called when the selected video exceeds the permitted size limit
  /// Implementing classes must provide this method
  void onExceedingPermittedLimitsSize();

  /// Called when the selected video has an invalid file type
  /// Implementing classes must provide this method
  void onInvalidMimeType();
}

/// Data model representing a selected video with its details
final class VideoModel {
  /// File path to the video on device
  final String path;

  /// Original filename of the video
  final String fileName;

  /// Creates a new video model with the specified path and filename
  VideoModel({required this.path, required this.fileName});
}
