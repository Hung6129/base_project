class ExceptionBase implements Exception {
  /// Error code associated with the exception.
  final String code;

  /// Correlation ID for tracking purposes.
  late final String correlationId;

  /// Optional error message.
  final String? message;

  /// Constructs an [ExceptionBase] instance with the provided [code], [message], and optional [correlationId]. The value is from Command.metadata
  ExceptionBase({required this.code, this.message, String? correlationId}) {
    this.correlationId = correlationId ?? '1';
  }

  @override
  String toString() {
    return '$runtimeType: [$code, $correlationId, $message]';
  }
}
