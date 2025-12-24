// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TimeUsecase)
const timeUsecaseProvider = TimeUsecaseProvider._();

final class TimeUsecaseProvider
    extends $AsyncNotifierProvider<TimeUsecase, String?> {
  const TimeUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timeUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timeUsecaseHash();

  @$internal
  @override
  TimeUsecase create() => TimeUsecase();
}

String _$timeUsecaseHash() => r'c46c20996a1dac8d7a8bbb81c7d60c8e3abc71fb';

abstract class _$TimeUsecase extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
