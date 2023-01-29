import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/demo_service/bloc/demo_serivce_bloc.dart';
import 'demo_builder.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DemoSerivceBloc>(
          create: (_) =>
              DemoSerivceBloc()..add(const DemoSerivceEvent.started()),
        ),
      ],
      child: const DemoBuilder(),
    );
  }
}
