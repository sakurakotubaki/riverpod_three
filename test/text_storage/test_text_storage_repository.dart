import 'package:riverpod_three/text_storage/text_datasource.dart';

class TestTextStorageRepository {
  final TextDatasource _textDatasource;

  TestTextStorageRepository(this._textDatasource);

  Future<void> saveText(String key, String value) async {
    await _textDatasource.saveText(key, value);
  }

  Future<String?> readText(String key) async {
    return await _textDatasource.readText(key);
  }

  Future<void> deleteText(String key) async {
    await _textDatasource.deleteText(key);
  }
}