import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyboardModifier extends StatelessWidget {
  const KeyboardModifier({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.grey,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: CupertinoButton(
            padding: const EdgeInsets.only(right: 24, top: 8, bottom: 8),
            onPressed: () {
              focus.unfocus();
            },
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ),
    );
  }
}
