import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:riverpod_three/dio/dio_provider.dart';
import 'package:riverpod_three/dio/user_datasource.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
  });

  test('UserNotifier fetches users successfully', () async {
    // Mock data
    final mockData = [
      {'id': 1, 'name': 'Leanne Graham', 'email': 'Sincere@april.biz'},
      {'id': 2, 'name': 'Ervin Howell', 'email': 'Shanna@melissa.tv'},
    ];

    // Setup mock response
    dioAdapter.onGet(
      'https://jsonplaceholder.typicode.com/users',
      (server) => server.reply(200, mockData),
    );

    // Create ProviderContainer with overridden dioProvider
    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(dio),
      ],
    );
    addTearDown(container.dispose);

    // Read the provider (it's async, so we get AsyncValue)
    // We can wait for the future to complete
    final users = await container.read(userProvider.future);

    // Verify
    expect(users.length, 2);
    expect(users[0].name, 'Leanne Graham');
    expect(users[1].email, 'Shanna@melissa.tv');
  });
}
