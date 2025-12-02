import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_three/counter/counter.dart';

// 新しいテストユーティリティ
// ProviderContainer.test

// 2.0では、一般的なテストコードはcreateContainerという独自のユーティリティに依存していました。
// 3.0では、このユーティリティはRiverpodの一部となり、ProviderContainer.testという名前になりました。
// これは新しいコンテナを作成し、テスト終了後に自動的に破棄します。

void main() {
  test('CounterNotifier test', () {
    // ProviderContainerを作成
    final container = ProviderContainer.test();

    // 初期値の確認
    expect(container.read(counterProvider), 0);

    // メソッドの実行
    container.read(counterProvider.notifier).increment();

    // 状態の変化を確認
    expect(container.read(counterProvider), 1);
  });
}