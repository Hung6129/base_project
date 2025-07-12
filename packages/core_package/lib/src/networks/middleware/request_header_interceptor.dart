import 'package:core_package/src/networks/config/build_config_base.dart';
import 'package:dio/dio.dart';

class RequestHeaderInterceptor extends QueuedInterceptorsWrapper {
  final BuildConfigMode mode;

  RequestHeaderInterceptor(this.mode);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
