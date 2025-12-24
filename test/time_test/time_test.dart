import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mockito/mockito.dart';

import 'time_test.mocks.dart';

// モック化したいクラスの例（通常は別ファイルに定義されています）
abstract interface class TimeInterface {
  Future<void> saveTime(DateTime dateTime);
  Future<String?> getTime();
  Future<void> deleteTime();
}

// アノテーションはトップレベルに記述します
@GenerateMocks([TimeInterface])
void main() {
  test("TimeInterfaceのモックが正しく動作するかテストする", () async {
    // 1. モックの準備
    final mockTimeRepository = MockTimeInterface();
    
    // 2. コンテナの作成と破棄の登録
    final container = ProviderContainer(
      overrides: [
        // 本来はここでProviderをoverrideしてモックを注入します
        // timeRepositoryProvider.overrideWithValue(mockTimeRepository),
      ],
    );
    addTearDown(container.dispose);

    // 3. スタブの設定 (getTimeが呼ばれたら特定の文字列を返す)
    const expectedTimeString = "2025-12-31T23:59:59.000";
    when(mockTimeRepository.getTime())
        .thenAnswer((_) async => expectedTimeString);

    // 4. 実行 (本来はService経由などで呼び出されます)
    final result = await mockTimeRepository.getTime();

    // 5. 検証
    expect(result, expectedTimeString); // 戻り値が期待通りか
    verify(mockTimeRepository.getTime()).called(1); // メソッドが1回呼ばれたか
  });
}