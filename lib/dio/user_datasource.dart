// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_three/dio/dio_provider.dart';

part 'user_datasource.freezed.dart';
part 'user_datasource.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<List<User>> build() async {
    return fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get('https://jsonplaceholder.typicode.com/users');
    
    final List<dynamic> data = response.data;
    final List<User> users = [];
    
    // Using for loop as requested
    for (var item in data) {
      users.add(User.fromJson(item));
    }
    
    return users;
  }
}
