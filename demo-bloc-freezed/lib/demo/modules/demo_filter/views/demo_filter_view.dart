import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/demo_filter_bloc.dart';
import '../widgets/filter_widget.dart';

class DemoFilterView extends StatelessWidget {
  const DemoFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemoFilterBloc, DemoFilterState>(
      builder: (context, state) => state.when(
        initial: (filter) => FilterWidget(
          filter: filter,
        ),
        success: (filter) => FilterWidget(
          filter: filter,
        ),
        loading: Container.new, //TODO: loading widget here
        failure: Container.new, //TODO: failure widget here
      ),
    );
  }
}
