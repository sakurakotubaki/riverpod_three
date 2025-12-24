# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Code generation (Riverpod, Freezed, JSON serializable)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous code generation
dart run build_runner watch --delete-conflicting-outputs

# Run all tests
flutter test

# Run a single test file
flutter test test/counter/counter_test.dart

# Analyze code
flutter analyze

# Get dependencies
flutter pub get
```

## Architecture

This is a Flutter project demonstrating Riverpod 3.0 state management patterns with offline caching capabilities.

### Module Structure

```
lib/
├── counter/          # Simple synchronous state (NotifierProvider)
├── dio/              # API data fetching (AsyncNotifierProvider + Dio)
├── riverpod_sqfilite/ # Local DB persistence (@JsonPersist + SQFlite)
└── offline/          # Offline caching with network detection
```

### Riverpod 3.0 Patterns

- **Code Generation**: All providers use `@riverpod` annotation. Provider names are generated without the `Notifier` suffix (e.g., `CounterNotifier` → `counterProvider`).
- **Testing**: Use `ProviderContainer.test()` for automatic cleanup.
- **Persistence**: Use `@JsonPersist()` with `riverpod_sqflite` for automatic SQLite storage.

### Key Technologies

- **Riverpod 3.0**: State management with code generation
- **Freezed**: Immutable data classes with JSON serialization
- **riverpod_sqflite**: Automatic state persistence to SQLite
- **Dio**: HTTP client for API requests

### Offline Caching Pattern (lib/offline/)

Uses `NetworkStatus` enum with Dart 3.0 switch expressions and sealed `CacheState<T>` class for type-safe cache state handling:
- `FreshData` - Data from API (online)
- `CachedData` - Data from SQLite cache (offline)
- `LoadingData` / `ErrorData` - Loading and error states

### Generated Files

Files ending in `.g.dart` and `.freezed.dart` are auto-generated. After modifying models or providers, run `dart run build_runner build --delete-conflicting-outputs`.

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