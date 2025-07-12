import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_package/src/base/storage.dart';

/// {@template persistent_storage}
/// Storage that saves data in the device's persistent memory.
/// {@endtemplate}
@lazySingleton
class PersistentStorage implements Storage {
  /// {@macro persistent_storage}
  const PersistentStorage({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @factoryMethod
  @preResolve
  static Future<PersistentStorage> init() async {
    return PersistentStorage(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
  }

  final SharedPreferences _sharedPreferences;

  /// Returns value for the provided [key] from storage.
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  @override
  Future<String?> read({required String key}) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  /// Writes the provided [key], [value] pair into storage.
  ///
  /// Throws a [StorageException] if the write fails.
  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  /// Removes the value for the provided [key] from storage.
  ///
  /// Throws a [StorageException] if the delete fails.
  @override
  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  /// Removes all key, value pairs from storage.
  ///
  /// Throws a [StorageException] if the clear fails.
  @override
  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }
}

class InAppMemoryStorage implements Storage {
  final Map<String, String> _storage;

  InAppMemoryStorage() : _storage = {};

  @override
  Future<void> clear() async {
    _storage.clear();
  }

  @override
  Future<void> delete({required String key}) async {
    _storage.remove(key);
  }

  @override
  Future<String?> read({required String key}) async {
    if (_storage.containsKey(key)) {
      return _storage[key];
    }

    return null;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    _storage[key] = value;
  }
}
