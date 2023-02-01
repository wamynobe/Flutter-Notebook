import 'package:flutter/material.dart';

import 'dismiss_keyboard.dart';
import 'overflow_text_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  final _nameTextController = TextEditingController();
  final _nameTextEllipsisController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _addressTextEllipsisController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OverFlowTextFormField(
                textController: _nameTextController,
                textEllipsisController: _nameTextEllipsisController,
                name: 'name',
                validateMessage: 'Please enter name',
                isRequired: true,
                validateFunction: (value) {},
                focusNode: _nameFocusNode,
                onFocusOut: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              OverFlowTextFormField(
                kType: TextInputType.number,
                textController: _addressTextController,
                textEllipsisController: _addressTextEllipsisController,
                name: 'address',
                validateMessage: 'Please enter address',
                isRequired: true,
                focusNode: _addressFocusNode,
                validateFunction: (value) {},
                onFocusOut: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
