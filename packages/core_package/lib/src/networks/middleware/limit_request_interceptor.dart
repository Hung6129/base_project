import 'package:dio/dio.dart';

class LimitRequestInterceptor extends QueuedInterceptor {
  final int maxRequestAttempt = 1;
  int conCurrent = 0;

  LimitRequestInterceptor();

  void reset() {
    conCurrent = 0;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    reset();
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (conCurrent < maxRequestAttempt) {
      conCurrent++;
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    reset();
    return handler.next(response);
  }
}
