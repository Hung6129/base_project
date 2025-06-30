import 'dart:developer' as dev;

final class AppLogger extends LoggerPort {
  @override
  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message, error: error, stackTrace: stackTrace);
  }

  @override
  void log(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warn(String message, {Object? error, StackTrace? stackTrace}) {
    dev.log(message, error: error, stackTrace: stackTrace);
  }
}

/// Abstract class representing a logger port.
abstract class LoggerPort {
  /// Logs a message.
  void log(String message, {Object? error, StackTrace? stackTrace});

  /// Logs an error message.
  void error(String message, {Object? error, StackTrace? stackTrace});

  /// Logs a warning message.
  void warn(String message, {Object? error, StackTrace? stackTrace});

  /// Logs a debug message.
  void debug(String message, {Object? error, StackTrace? stackTrace});
}
