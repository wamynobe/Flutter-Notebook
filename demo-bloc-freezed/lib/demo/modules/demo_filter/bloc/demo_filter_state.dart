part of 'demo_filter_bloc.dart';

@freezed
class DemoFilterState with _$DemoFilterState {
  const factory DemoFilterState.initial({required int filter}) = _Initial;
  const factory DemoFilterState.loading() = _Loading;
  const factory DemoFilterState.success({
    required int filter,
  }) = _Success;
  const factory DemoFilterState.failure() = _Failure;
}
