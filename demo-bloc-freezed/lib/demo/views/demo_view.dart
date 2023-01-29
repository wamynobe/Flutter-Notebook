import 'package:flutter/material.dart';

import '../modules/demo_filter/views/demo_filter_view.dart';
import '../modules/demo_search/views/demo_search_view.dart';
import '../modules/demo_service/views/serive_view.dart';

class DemoView extends StatelessWidget {
  DemoView({super.key});
  final searchTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            SizedBox(
              height: 40,
            ),
            DemoSearchView(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: DemoFilterView(),
            ),
            Expanded(
              child: DemoServiceView(),
            ),
          ],
        ),
      ),
    );
  }
}
