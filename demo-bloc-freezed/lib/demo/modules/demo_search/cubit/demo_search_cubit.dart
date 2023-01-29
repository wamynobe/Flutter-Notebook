import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../demo_service/bloc/demo_serivce_bloc.dart';

part 'demo_search_cubit.freezed.dart';
part 'demo_search_state.dart';

class DemoSearchCubit extends Cubit<DemoSearchState> {
  DemoSearchCubit(this.svBloc) : super(const DemoSearchState.initial());
  final DemoSerivceBloc svBloc;
  Future<void> searchWithQuerry({
    required String query,
    required int filter,
  }) async {
    //search data
    emit(
      DemoSearchState.success(
        querry: query,
      ),
    );
    svBloc.add(
      DemoSerivceEvent.userInteracted(filter: filter, searchQuery: query),
    );
  }
}
