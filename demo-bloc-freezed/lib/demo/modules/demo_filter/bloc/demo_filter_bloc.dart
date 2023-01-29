import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../demo_service/bloc/demo_serivce_bloc.dart';

part 'demo_filter_bloc.freezed.dart';
part 'demo_filter_event.dart';
part 'demo_filter_state.dart';

class DemoFilterBloc extends Bloc<DemoFilterEvent, DemoFilterState> {
  DemoFilterBloc(this.svBloc)
      : super(const DemoFilterState.initial(filter: -1)) {
    on<DemoFilterEvent>(_onEvent);
  }
  final DemoSerivceBloc svBloc;
  FutureOr<void> _onEvent(
    DemoFilterEvent event,
    Emitter<DemoFilterState> emit,
  ) async {
    event.when(
      started: (userChoice) {
        emit(const DemoFilterState.success(filter: -1));
      },
      userSelected: (userChoice, searchQuery) {
        emit(DemoFilterState.success(filter: userChoice));
        svBloc.add(
          DemoSerivceEvent.userInteracted(
            filter: userChoice,
            searchQuery: searchQuery,
          ),
        );
      },
    );
  }
}
