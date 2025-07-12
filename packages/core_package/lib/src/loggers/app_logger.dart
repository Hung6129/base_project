import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  d(dynamic message) {
    _logger.d(message);
  }

  void e(dynamic message) {
    _logger.e(message);
  }

  void i(dynamic message) {
    _logger.i(message);
  }

  void w(dynamic message) {
    _logger.w(message);
  }

  void v(dynamic message) {
    _logger.t(message);
  }

  void E(dynamic message, Object? error, StackTrace? stackTrace) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
