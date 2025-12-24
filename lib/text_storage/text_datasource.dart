import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TextDatasource {
  final FlutterSecureStorage secureStorage;
  TextDatasource(this.secureStorage);

  // save data
  Future<void> saveText(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
  // read data
  Future<String?> readText(String key) async {
    return await secureStorage.read(key: key);
  }

  // delete data
  Future<void> deleteText(String key) async {
    await secureStorage.delete(key: key);
  }
}