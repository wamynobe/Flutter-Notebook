import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../demo_search/cubit/demo_search_cubit.dart';
import '../bloc/demo_filter_bloc.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.filter,
  });
  final int filter;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(
          color: index == filter ? Colors.grey : Colors.white,
        ),
        child: TextButton(
          onPressed: filter == index
              ? null
              : () async {
                  context.read<DemoFilterBloc>().add(
                        DemoFilterEvent.userSelected(
                          userChoice: index,
                          searchQuerry:
                              context.read<DemoSearchCubit>().state.when(
                                    initial: () => '',
                                    loading: () => '',
                                    success: (searchQuerry) => searchQuerry,
                                  ),
                        ),
                      );
                },
          child: Text('filter $index'),
        ),
      ),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
