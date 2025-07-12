//@GeneratedMicroModule;StoragePackagePackageModule;package:storage_package/storage_package.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:injectable/injectable.dart' as _i526;
import 'package:storage_package/src/persistent_storage.dart' as _i225;
import 'package:storage_package/src/secure_storage.dart' as _i1022;

class StoragePackagePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    gh.lazySingleton<_i1022.SecureStorage>(() => const _i1022.SecureStorage());
    await gh.lazySingletonAsync<_i225.PersistentStorage>(
      () => _i225.PersistentStorage.init(),
      preResolve: true,
    );
  }
}
