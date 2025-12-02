// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
// ignore: implementation_imports
import 'package:riverpod_annotation/experimental/json_persist.dart';
import 'package:riverpod_annotation/experimental/persist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart'; // debugPrintのために追加

part 'todo.g.dart';
part 'todo.freezed.dart';

@riverpod
Future<JsonSqFliteStorage> storage(Ref ref) async {
  debugPrint('StorageProvider: Initializing...');
  // Initialize SQFlite. We should share the Storage instance between providers.
  final path = await getDatabasesPath();
  final dbPath = join(path, 'riverpod.db');
  debugPrint('StorageProvider: DB Path: $dbPath');
  
  final storage = await JsonSqFliteStorage.open(dbPath);
  debugPrint('StorageProvider: Opened successfully');
  return storage;
}

/// A serializable Todo class. We're using Freezed for simple serialization.
@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String description,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

@riverpod
@JsonPersist()
class TodosNotifier extends _$TodosNotifier {
  @override
  FutureOr<List<Todo>> build() async {
    debugPrint('TodosNotifier: build started');
    
    // 修正: Storageの準備ができるまで待機する
    // これにより、DBが開くまではこのプロバイダーは「AsyncLoading」状態になります
    debugPrint('TodosNotifier: Waiting for storage...');
    final storage = await ref.watch(storageProvider.future);
    debugPrint('TodosNotifier: Storage received');

    // We call persist at the start of our 'build' method.
    // This will:
    // - Read the DB and update the state with the persisted value the first
    //   time this method executes.
    // - Listen to changes on this provider and write those changes to the DB.
    debugPrint('TodosNotifier: Calling persist...');
    persist(
      // We pass our JsonSqFliteStorage instance. No need to "await" the Future.
      // Riverpod will take care of that.
      storage,
      // By default, state is cached offline only for 2 days.
      // We can optionally uncomment the following line to change cache duration.
      // options: const StorageOptions(cacheTime: StorageCacheTime.unsafe_forever),
    );
    debugPrint('TodosNotifier: persist called');

    // 初期値として空リストを返しますが、persistがDBからデータを読み込むと
    // 自動的にそのデータでstateが上書きされます。
    return [];
  }

  Future<void> add(Todo todo) async {
    debugPrint('TodosNotifier: Adding todo ${todo.id}');
    // When modifying the state, no need for any extra logic to persist the change.
    // Riverpod will automatically cache the new state and write it to the DB.
    state = AsyncData([...?state.value, todo]);
  }
  
  Future<void> toggle(int id) async {
    debugPrint('TodosNotifier: Toggling todo $id');
    final todos = state.value;
    if (todos == null) return;
    state = AsyncData([
      for (final todo in todos)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo,
    ]);
  }
  
  Future<void> remove(int id) async {
    debugPrint('TodosNotifier: Removing todo $id');
    final todos = state.value;
    if (todos == null) return;
    state = AsyncData([
      for (final todo in todos)
        if (todo.id != id) todo,
    ]);
  }
}