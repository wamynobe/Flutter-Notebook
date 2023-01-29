part of 'demo_search_cubit.dart';

@freezed
class DemoSearchState with _$DemoSearchState {
  const factory DemoSearchState.initial() = _Initial;
  const factory DemoSearchState.loading() = _LoadInProgress;
  const factory DemoSearchState.success({
    required String querry,
  }) = _Success;
}
