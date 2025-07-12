// import 'package:core_module/core_module.dart';
// import 'package:dio/dio.dart';
// import 'package:fresh_dio/fresh_dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:infrast/src/modules/user/data/models/user_token_model.dart';
// import 'package:infrast/src/providers/storages/authentication_token_storage.dart';
// import 'package:injectable/injectable.dart';

// @LazySingleton()
// final class M2eAuthRequestInterceptor extends Fresh<UserTokenModel> {
//   final BuildConfigMode config;
//   final AuthenticationTokenStorage storage;

//   M2eAuthRequestInterceptor(
//       {required this.config, required this.storage, super.httpClient})
//       : super(
//           tokenHeader: (UserTokenModel token) {
//             return {'Authorization': 'Bearer ${token.token}'};
//           },
//           tokenStorage: storage,
//           refreshToken: (token, client) async {
//             try {
//               throwIf(token?.refreshToken == null || token?.refreshToken == '',
//                   RevokeTokenException());
//               final data = await client.fetch<Map<String, dynamic>>(
//                   RequestOptions(
//                       path: '/api/v1/auth/refresh',
//                       method: 'POST',
//                       headers: {
//                     'Authorization': 'Bearer ${token!.refreshToken}',
//                   }));
//               if (data.data != null) {
//                 return UserTokenModel.fromJson(data.data!);
//               } else {
//                 throw RevokeTokenException();
//               }
//             } catch (e) {
//               throw RevokeTokenException();
//             }
//           },

//         );
// }
