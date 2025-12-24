import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_three/text_storage/text_datasource.dart';

import 'test_text_storage_repository.dart';

void main () {
  // Flutterのテスト環境を初期化します。
  // プラグイン（flutter_secure_storageなど）を使用する場合、
  // バックグラウンドのチャネル通信をセットアップするために必要です。
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Textが保存できているかのテスト", () async {
    // 単体テスト環境では実機のようなセキュアストレージが存在しないため、
    // モックの初期値を設定してMissingPluginExceptionを防ぎます。
    FlutterSecureStorage.setMockInitialValues({});

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final TestTextStorageRepository repository = TestTextStorageRepository(
      TextDatasource(secureStorage),
    );
    
    const String testKey = "test_key;";
    const String testValue = "This is a test value.";
    // Save text
    await repository.saveText(testKey, testValue);
    // Read text
    final String? retrievedValue = await repository.readText(testKey);
    expect(retrievedValue, testValue);
    // Delete text
    await repository.deleteText(testKey);
    final String? deletedValue = await repository.readText(testKey);
    expect(deletedValue, isNull);
  });
}