import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:riverpod_three/counter/counter_view.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Riverpodを使用するウィジェットをテストする場合、ProviderScopeでラップする必要があります
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CounterView(),
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // 指定されたKeyを使用してFloatingActionButtonを探し、タップします
    await tester.tap(find.byKey(const Key('increment_floatingActionButton')));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}