// import 'package:core_module/core_module.dart';
// import 'package:dio/dio.dart';
// import 'package:infrast/src/modules/user/data/models/user_token_model.dart';
// import 'package:infrast/src/providers/remote/interceptors/m2e_auth_request_interceptor.dart';
// import 'package:infrast/src/providers/remote/interceptors/m2e_request_interceptor.dart';
// import 'package:infrast/src/providers/storages/authentication_token_storage.dart';
// import 'package:injectable/injectable.dart';
// import 'package:storage_module/storage_module.dart';

// @Singleton()
// final class M2eProvider extends HttpClient {
//   final BuildConfigMode config;

//   late final Dio refreshTokenDio;

//   late final M2eAuthRequestInterceptor authRequestInterceptor;

//   final AuthenticationTokenStorage storage;

//   final SecureStorage _secureStorage;

//   M2eProvider(
//     this.config,
//     this.storage,
//     this._secureStorage, {
//     required super.loggerPort,
//   }) {
//     initialize();
//   }

//   @override
//   void buildBaseOptions() {
//     print(config.endPoint);
//     dio = Dio(
//       BaseOptions(
//         baseUrl: config.endPoint,
//         connectTimeout: Duration(milliseconds: config.connectTimeout),
//         sendTimeout: Duration(milliseconds: config.connectTimeout),
//         receiveTimeout: Duration(milliseconds: config.receiveTimeout),
//         validateStatus: (status) {
//           if (status != null) {
//             return status != 401 || status < 500;
//           }
//           return false;
//         },
//       ),
//     );
//     refreshTokenDio = Dio(
//       BaseOptions(
//         baseUrl: config.endPoint,
//         connectTimeout: Duration(milliseconds: config.connectTimeout),
//         sendTimeout: Duration(milliseconds: config.connectTimeout),
//         receiveTimeout: Duration(milliseconds: config.receiveTimeout),
//       ),
//     );
//   }

//   @override
//   void initialize() {
//     buildBaseOptions();
//     addInterceptors();
//   }

//   @override
//   void addInterceptors() {
//     refreshTokenDio.interceptors.add(
//       M2eRequestInterceptor(config, _secureStorage),
//     );
//     dio.interceptors.add(M2eRequestInterceptor(config, _secureStorage));
//     dio.interceptors.add(
//       authRequestInterceptor = M2eAuthRequestInterceptor(
//         config: config,
//         httpClient: refreshTokenDio,
//         storage: storage,
//       ),
//     );
//   }

//   @override
//   void close() {
//     dio.close();
//   }

//   @override
//   void dispose() {
//     dio.close(force: true);
//   }

//   Future<void> setToken(UserTokenModel? token) async {
//     return authRequestInterceptor.setToken(token);
//   }

//   Future<void> revokeToken() async {
//     return authRequestInterceptor.setToken(null);
//   }
// }
