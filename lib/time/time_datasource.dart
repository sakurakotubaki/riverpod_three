import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/time/secure_storage.dart';
part 'time_datasource.g.dart';

@Riverpod(keepAlive: true)
TimeDatasource timeDatasource(Ref ref) {
  final secureStorage = ref.watch(flutterSecureStorageProvider);
  return TimeDatasource(secureStorage);
}

final class TimeDatasource {
  final FlutterSecureStorage _secureStorage;
  TimeDatasource(this._secureStorage);

  Future<void> saveTime(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getTime(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteTime(String key) async {
    await _secureStorage.delete(key: key);
  }
}