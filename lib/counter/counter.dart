import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'counter.g.dart';

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
   build() {
    return 0;
  }

  void increment() {
    state++;
  }
}