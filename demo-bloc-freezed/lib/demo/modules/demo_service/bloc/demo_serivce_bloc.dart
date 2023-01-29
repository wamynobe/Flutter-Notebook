import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo_serivce_bloc.freezed.dart';
part 'demo_serivce_event.dart';
part 'demo_serivce_state.dart';

class DemoSerivceBloc extends Bloc<DemoSerivceEvent, DemoSerivceState> {
  DemoSerivceBloc() : super(const DemoSerivceState.initial()) {
    on(_onEvent);
  }
  FutureOr<void> _onEvent(
    DemoSerivceEvent event,
    Emitter<DemoSerivceState> emit,
  ) async {
    event.when(
      started: () {
        final list = ['1', '2', '3', '4456', '45', '6'];
        emit(
          DemoSerivceState.loaded(
            data: list,
          ),
        );
      },
      userInteracted: (filter, searchQuery) {
        final list = ['1', '2', '3', '4456', '45', '6'];
        final listData = list
            .where(
              (element) => element.contains(searchQuery),
            )
            .where(
              (element) => filter == -1
                  ? filter == -1
                  : element.contains(
                      filter.toString(),
                    ),
            );
        emit(
          DemoSerivceState.loaded(
            data: listData.toList(),
          ),
        );
      },
    );
  }
}
