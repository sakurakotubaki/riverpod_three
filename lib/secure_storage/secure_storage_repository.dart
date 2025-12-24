import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/secure_storage/secure_storage_datasource.dart';
import 'package:riverpod_three/secure_storage/secure_storage_interface.dart';
part 'secure_storage_repository.g.dart';

@Riverpod(keepAlive: true)
SecureStorageRepository secureStorageRepositoryProvider(Ref ref) {
  final datasource = SecureStorageDatasource();
  return SecureStorageRepository(datasource);
}

class SecureStorageRepository implements SecureStorageInterface {
  final SecureStorageDatasource _datasource;
  SecureStorageRepository(this._datasource);

  @override
  Future<void> write(String key, String value) async {
    await _datasource.write(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return await _datasource.read(key);
  }

  @override
  Future<void> delete(String key) async {
    await _datasource.delete(key);
  }
  
  @override
  Future<void> deleteAll() async {
    await _datasource.deleteAll();
  }
}