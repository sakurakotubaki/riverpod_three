# テストケース: UserNotifier (Dio Integration)

## 概要
`UserNotifier` が Dio を使用して外部 API (JSONPlaceholder) からユーザーデータを正しく取得できるかを検証する。
`http_mock_adapter` を使用して HTTP リクエストをモックし、実際のネットワーク通信を行わずにテストを行う。

## テスト内容

### ケース 1: ユーザー取得成功

*   **前提条件**:
    *   `dioProvider` がモックアダプター付きの Dio インスタンスでオーバーライドされていること。
    *   API エンドポイント `https://jsonplaceholder.typicode.com/users` がステータスコード 200 と正常なユーザーリストの JSON を返すように設定されていること。

*   **手順**:
    1.  `ProviderContainer` を作成し、`dioProvider` をオーバーライドする。
    2.  `userProvider.future` を読み取り、完了を待機する。

*   **期待値**:
    *   取得されたユーザーリストの要素数がモックデータの数と一致すること（例: 2件）。
    *   各ユーザーのデータ（名前、メールアドレスなど）がモックデータと一致すること。

## 担当者
Jboy
