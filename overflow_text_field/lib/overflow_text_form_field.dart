import 'dart:async';

import 'package:flutter/material.dart';

class OverFlowTextFormField extends StatefulWidget {
  const OverFlowTextFormField({
    Key? key,
    required this.textController,
    required this.name,
    required this.validateMessage,
    this.kType = TextInputType.text,
    this.onTap,
    this.focusNode,
    this.textEllipsisController,
    required this.isRequired,
    required this.validateFunction,
    required this.onFocusOut,
  }) : super(key: key);
  final TextEditingController textController;
  final TextEditingController? textEllipsisController;
  final String name;
  final bool isRequired;
  final String validateMessage;
  final VoidCallback? onTap;
  final String? Function(String?) validateFunction;
  final String? Function(String) onFocusOut;
  final TextInputType kType;
  final FocusNode? focusNode;

  @override
  State<OverFlowTextFormField> createState() => _OverFlowTextFormFieldState();
}

class _OverFlowTextFormFieldState extends State<OverFlowTextFormField> {
  final firstTimeRenderConstraints = Completer<BoxConstraints>();
  Color colorsBorder = const Color.fromRGBO(225, 230, 238, 1);
  bool isValidated = true;
  String validateMessage = '';
  ScrollController scrollController = ScrollController();
  String currentStringValue = '';

  @override
  void initState() {
    currentStringValue = widget.textController.text;
    if (widget.textEllipsisController != null) {
      widget.textEllipsisController!.text = widget.textController.text;
    }
    //first time render need this postFrameCallback to render text
    //overflow ellipsis
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        final replaceIndex = _getReplaceIndex(
            Theme.of(context).textTheme.bodyText2,
            1,
            await firstTimeRenderConstraints.future,
            context);
        if (replaceIndex != -1) {
          widget.textEllipsisController?.text = _getOverFlowText(
              value: widget.textController.text, index: replaceIndex);
        }
        setState(() {
          colorsBorder = Colors.grey;
        });
      },
    );
    super.initState();

    validateMessage = widget.validateMessage;
  }

  @override
  Widget build(BuildContext context) {
    final constrainsFuture = Completer<BoxConstraints>();
    return Focus(
      onFocusChange: (value) async {
        if (!value) {
          //when lose focus count number of texts appear on screen then replace
          //some last text with '...'
          final replaceIndex = _getReplaceIndex(
              Theme.of(context).textTheme.bodyText2,
              1,
              await constrainsFuture.future,
              context);
          if (replaceIndex != -1) {
            widget.textEllipsisController?.text = _getOverFlowText(
                value: widget.textController.text, index: replaceIndex);
          }

          scrollController.jumpTo(0);
          setState(() {
            final result = widget.onFocusOut(widget.textController.text);
            if (result != null) {
              //change validate message due to result here
              isValidated = false;
            } else {
              isValidated = true;
            }
          });
        } else {
          //when focus text field set value to the value
          //before make short with ellipsis overflow
          widget.textEllipsisController?.text = currentStringValue;
        }
        setState(() {
          colorsBorder = value
              ? Colors.green
              : isValidated
                  ? Colors.grey
                  : Colors.red;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 350,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: colorsBorder),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              //get current text box constraints for first time
              //render and each time rerender
              if (!firstTimeRenderConstraints.isCompleted) {
                //first time render use this constraints to caculate how many
                //texts appear on screen
                firstTimeRenderConstraints.complete(constraints);
              }
              constrainsFuture.complete(constraints);
              return Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        focusNode: widget.focusNode,
                        scrollController: scrollController,
                        maxLines: 1,
                        keyboardType: widget.kType,
                        controller: widget.textEllipsisController ??
                            widget.textController,
                        maxLength: 255,
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(height: 0),
                          counterText: '',
                          isDense: true,
                          label: RichText(
                            text: TextSpan(
                              text: widget.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.grey),
                              children: [
                                if (widget.isRequired)
                                  const TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          if (widget.onTap != null) {
                            widget.onTap!();
                          }
                        },
                        onChanged: (value) {
                          currentStringValue = value;
                          widget.textController.text = value;
                          setState(() {});
                        },
                        validator: (value) {
                          final result = widget.validateFunction(value);
                          if (result != null) {
                            //you can change validate message due to result here
                            setState(() {
                              isValidated = false;
                              colorsBorder = Colors.red;
                            });
                            return '';
                          } else {
                            return result;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(
            height: 5,
          ),
          isValidated
              ? const SizedBox.shrink()
              : Text(
                  validateMessage,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.red),
                ),
        ],
      ),
    );
  }

//replace current text with shorter text by ellipsis overflow
  double _getReplaceIndex(TextStyle? style, int? maxLines,
      BoxConstraints constraints, BuildContext context) {
    final span = TextSpan(
      style: style,
      text: widget.textController.text,
    );
    if (_checkTextFits(span, 1, maxLines, constraints)) {
      return -1;
    } else {
      final t = constraints.maxWidth / _textDetails(context, 'a').width;
      return t;
    }
  }

  //get text size to count number of chars appear on the screen
  Size _textDetails(BuildContext context, String char) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: char,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      textDirection: TextDirection.ltr,
      textScaleFactor: 1,
    )..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width);
    return textPainter.size;
  }

  String _getOverFlowText({required String value, required double index}) {
    if (value.length <= index) {
      return value;
    }
    final newValue = value.substring(0, index.ceil() - 2);
    return '$newValue...';
  }

//check if text is fit the text box or not
  bool _checkTextFits(
      TextSpan text, double scale, int? maxLines, BoxConstraints constraints) {
    final constraintWidth = constraints.maxWidth;

    var word = text.toPlainText();

    if (word.isNotEmpty) {
      final textContents = text.text ?? '';
      word = textContents.replaceAll('\n', ' \n');
      if (textContents.codeUnitAt(textContents.length - 1) != 10 &&
          textContents.codeUnitAt(textContents.length - 1) != 32) {
        word += ' ';
      }
    }

    final tp = TextPainter(
      text: TextSpan(
        text: word,
        recognizer: text.recognizer,
        children: text.children,
        semanticsLabel: text.semanticsLabel,
        style: text.style,
      ),
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      textScaleFactor: scale,
      maxLines: maxLines,
    );
    tp.layout(minWidth: constraintWidth);
    final _width = tp.width;
    //check if text's witdh greater than max width
    if (_width > constraintWidth) {
      return false;
    } else {
      return true;
    }
  }
}
