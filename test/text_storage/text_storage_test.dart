import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_three/text_storage/text_datasource.dart';

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
    final TextDatasource textDatasource = TextDatasource(
      secureStorage,
    );
    const String testKey = "test_key;";
    const String testValue = "This is a test value.";
    // Save text
    await textDatasource.saveText(testKey, testValue);
    // Read text
    final String? retrievedValue = await textDatasource.readText(testKey);
    expect(retrievedValue, testValue);
    // case about
    // expect(retrievedValue, "こんにちわ"); // 失敗するテストケース
    // Delete text
    await textDatasource.deleteText(testKey);
    final String? deletedValue = await textDatasource.readText(testKey);
    expect(deletedValue, isNull);
  });
}