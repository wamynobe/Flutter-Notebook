import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
    required this.data,
  });
  final List<String> data;
  @override
  Widget build(BuildContext context) {
    final services = data.toList();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: services.length,
      itemBuilder: (context, index) => DecoratedBox(
        decoration: const BoxDecoration(color: Colors.red),
        child: Text(
          services[index],
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.green),
        ),
      ),
    );
  }
}
