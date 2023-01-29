import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/demo_filter/bloc/demo_filter_bloc.dart';
import '../modules/demo_search/cubit/demo_search_cubit.dart';
import '../modules/demo_service/bloc/demo_serivce_bloc.dart';
import 'demo_view.dart';

class DemoBuilder extends StatelessWidget {
  const DemoBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DemoSearchCubit>(
          create: (_) => DemoSearchCubit(context.read<DemoSerivceBloc>()),
        ),
        BlocProvider<DemoFilterBloc>(
          create: (_) => DemoFilterBloc(context.read<DemoSerivceBloc>()),
        ),
      ],
      child: DemoView(),
    );
  }
}
