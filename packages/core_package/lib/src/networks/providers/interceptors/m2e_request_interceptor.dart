// import 'package:core_module/core_module.dart';
// import 'package:device_module/device_module.dart';
// import 'package:dio/dio.dart';
// import 'package:storage_module/storage_module.dart';

// final class M2eRequestInterceptor extends RequestHeaderInterceptor {
//   final SecureStorage _secureStorage;
//   M2eRequestInterceptor(super.mode, this._secureStorage);

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final deviceId = DeviceHelper.getDeviceId();
//     final language = await _secureStorage.read(key: 'languageCode');

//     options.headers.addEntries([
//       MapEntry('x-custom-device-id', deviceId),
//       MapEntry('x-custom-lang', language ?? 'en'),
//     ]);
//     return super.onRequest(options, handler);
//   }
// }
