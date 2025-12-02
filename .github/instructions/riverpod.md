---
applyTo: '**'
---

新しいRiverpodのRefについてですが、引数にはRefと書くだけで良くなりました。

⭕️これが正しい

```dart
@riverpod
Future<String> boredSuggestion(Ref ref) async {
  final response = await http.get(
    Uri.https('boredapi.com', '/api/activity'),
  );
  final json = jsonDecode(response.body);
  return json['activity']! as String;
}
```

❌これは間違い。もう古いコードです。

```dart
@riverpod
Future<String> boredSuggestion(BoredSuggestionRef ref) async {
  final response = await http.get(
    Uri.https('boredapi.com', '/api/activity'),
  );
  final json = jsonDecode(response.body);
  return json['activity']! as String;
}
```

freezed3.0.0から`abstract`修飾子が必要になったのでつける。書き方の例は以下のようにする。

```dart
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

.whenは非推奨なので使用しないでください。switchが推奨です。

```dart
// body: todosAsync.when(
      //   data: (todos) => ListView.builder(
      //     itemCount: todos.length,
      //     itemBuilder: (context, index) {
      //       final todo = todos[index];
      //       return ListTile(
      //         title: Text(todo.description),
      //         leading: Checkbox(
      //           value: todo.completed,
      //           onChanged: (value) {
      //             ref.read(todosProvider.notifier).toggle(todo.id);
      //           },
      //         ),
      //         trailing: IconButton(
      //           icon: const Icon(Icons.delete),
      //           onPressed: () {
      //             ref.read(todosProvider.notifier).remove(todo.id);
      //           },
      //         ),
      //       );
      //     },
      //   ),
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (error, stack) => Center(child: Text('Error: $error')),
      // ),
```