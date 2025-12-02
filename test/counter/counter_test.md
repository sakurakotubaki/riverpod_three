# テストケース: CounterNotifier

## 概要
`CounterNotifier` の基本的な動作（初期値とインクリメント機能）を検証する。
Riverpod 3.0 の `ProviderContainer.test()` ユーティリティを使用してテストを行う。

## テスト内容

### ケース 1: 初期値とインクリメントの確認

*   **手順**:
    1.  `ProviderContainer.test()` を使用してコンテナを作成する。
    2.  `counterProvider` の初期値を読み取る。
    3.  `counterProvider.notifier` の `increment()` メソッドを実行する。
    4.  `counterProvider` の値を再度読み取る。

*   **期待値**:
    *   手順2で読み取った初期値が `0` であること。
    *   手順4で読み取った値が `1` であること（状態が更新されていること）。

## 担当者
Jboy
