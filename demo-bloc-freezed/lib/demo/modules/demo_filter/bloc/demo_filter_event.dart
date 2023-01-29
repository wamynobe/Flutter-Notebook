part of 'demo_filter_bloc.dart';

@freezed
class DemoFilterEvent with _$DemoFilterEvent {
  const factory DemoFilterEvent.started({required int userChoice}) = _Started;
  const factory DemoFilterEvent.userSelected({
    required int userChoice,
    required String searchQuerry,
  }) = _Selected;
}
