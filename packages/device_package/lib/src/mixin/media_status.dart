import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Represents the status of permission operations across the app
///
/// These status values align with the permission_handler package's values
/// but provide a layer of abstraction for the application
enum Status {
  /// The user denied access to the requested feature, permission needs to be
  /// asked first.
  denied,

  /// The user granted access to the requested feature.
  granted,

  /// The OS denied access to the requested feature. The user cannot change
  /// this app's status, possibly due to active restrictions such as parental
  /// controls being in place.
  ///
  /// *Only supported on iOS.*
  restricted,

  /// The user has authorized this application for limited access. So far this
  /// is only relevant for the Photo Library picker.
  ///
  /// *Only supported on iOS (iOS14+).*
  limited,

  /// Permission to the requested feature is permanently denied, the permission
  /// dialog will not be shown when requesting this permission. The user may
  /// still change the permission status in the settings.
  ///
  /// *On Android:*
  /// Android 11+ (API 30+): whether the user denied the permission for a second
  /// time.
  /// Below Android 11 (API 30): whether the user denied access to the requested
  /// feature and selected to never again show a request.
  ///
  /// *On iOS:*
  /// If the user has denied access to the requested feature.
  permanentlyDenied,

  /// The application is provisionally authorized to post non-interruptive user
  /// notifications.
  ///
  /// *Only supported on iOS (iOS12+).*
  provisional,
}

/// Represents the current state of media processing operations
///
/// This enum is used throughout the app to track and display media operations
/// progress, enabling consistent UI feedback during potentially long operations
enum MediaStateType {
  /// Initial state, no operation in progress
  /// Used when no media operation has started or after reset
  init,

  /// Media is being processed
  /// Used during general media handling operations
  processing,

  /// Media is being optimized (e.g., compressed)
  /// Used during compression or resizing operations
  optimizing,

  /// Calculating media size/dimensions
  /// Used when determining file size or media dimensions
  calculatingLength,

  /// Operation completed successfully
  /// Used when a media operation completes without errors
  successful,
}

/// Singleton class that tracks and broadcasts media processing state changes
///
/// This class maintains a single source of truth for media state across
/// the application, allowing components to react to state changes consistently.
@LazySingleton()
final class MediaState {
  /// Singleton instance accessor
  /// Use MediaState.instance throughout the app to access the same instance
  static final MediaState instance = MediaState._internal();

  /// Internal ValueNotifier that tracks the current media state
  /// Uses ValueNotifier pattern to notify listeners of state changes
  final ValueNotifier<MediaStateType> _mediaStateNotifier;

  /// Private constructor initializes the state notifier
  /// Ensures only one instance exists via the singleton pattern
  MediaState._internal()
    : _mediaStateNotifier = ValueNotifier(MediaStateType.init);

  /// Updates the current media state and notifies listeners
  ///
  /// Call this method whenever media operation state changes
  /// All listeners will be notified of the change
  void updateMediaState(MediaStateType state) {
    _mediaStateNotifier.value = state;
    // onMediaStateChanged(state);
  }

  /// Resets media state to initial value
  ///
  /// Call this method when all media operations are complete or canceled
  void initMediaState() => _mediaStateNotifier.value = MediaStateType.init;

  /// Public accessor for media state notifier
  ///
  /// Use this getter to listen for state changes across the application
  ValueNotifier<MediaStateType> get mediaStateNotifier => _mediaStateNotifier;
}
