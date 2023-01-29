part of 'demo_serivce_bloc.dart';

@freezed
class DemoSerivceEvent with _$DemoSerivceEvent {
  const factory DemoSerivceEvent.started() = _Started;
  const factory DemoSerivceEvent.userInteracted({
    required int filter,
    required String searchQuery,
  }) = _Interacted;
}
