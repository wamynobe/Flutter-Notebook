import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/demo_serivce_bloc.dart';
import '../widgets/service_widget.dart';

class DemoServiceView extends StatelessWidget {
  const DemoServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemoSerivceBloc, DemoSerivceState>(
      builder: (context, state) {
        return state.when(
          initial: Container.new,
          loading: Container.new,
          loaded: (data) => ServiceWidget(data: data),
        );
      },
    );
  }
}
