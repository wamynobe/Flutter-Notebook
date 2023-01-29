part of 'demo_serivce_bloc.dart';

@freezed
class DemoSerivceState with _$DemoSerivceState {
  const factory DemoSerivceState.initial() = _Initial;
  const factory DemoSerivceState.loading() = _Loading;
  const factory DemoSerivceState.loaded({
    required List<String> data,
  }) = _Loaded;
}
