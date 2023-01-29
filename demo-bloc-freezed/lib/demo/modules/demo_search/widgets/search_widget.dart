import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../demo_filter/bloc/demo_filter_bloc.dart';
import '../cubit/demo_search_cubit.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search',
        prefixIcon: Icon(Icons.search, size: 26),
        prefixIconColor: Color.fromRGBO(43, 46, 60, 1),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: (value) async {
        await context.read<DemoSearchCubit>().searchWithQuerry(
              query: value,
              filter: context.read<DemoFilterBloc>().state.maybeWhen(
                    orElse: () => -1,
                    success: (filter) => filter,
                  ),
            );
      },
    );
  }
}
