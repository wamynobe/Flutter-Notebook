import 'dart:async';

import 'package:flutter/material.dart';
import 'function.dart';

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
  OverlayEntry? _overlayEntry;
  @override
  void dispose() {
    super.dispose();
    if (widget.focusNode != null) {
      removeOverlay(
        _overlayEntry,
        () {
          _overlayEntry = null;
        },
      );
    }
  }

  @override
  void initState() {
    currentStringValue = widget.textController.text;
    if (widget.textEllipsisController != null) {
      widget.textEllipsisController!.text = widget.textController.text;
    }
    //first time render need this postFrameCallback to render text
    //overflow ellipse
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async {
        final replaceIndex = getReplaceIndex(
            Theme.of(context).textTheme.bodyText2,
            1,
            await firstTimeRenderConstraints.future,
            context,
            widget.textController);
        if (replaceIndex != -1) {
          widget.textEllipsisController?.text = getOverFlowText(
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
          if (widget.focusNode != null) {
            removeOverlay(
              _overlayEntry,
              () {
                _overlayEntry = null;
              },
            );
          }
          //when lose focus count number of texts appear on screen then replace
          //some last text with '...'
          final replaceIndex = getReplaceIndex(
              Theme.of(context).textTheme.bodyText2,
              1,
              await constrainsFuture.future,
              context,
              widget.textController);
          if (replaceIndex != -1) {
            widget.textEllipsisController?.text = getOverFlowText(
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
          if (widget.focusNode != null) {
            showOverlay(
              context,
              _overlayEntry,
              widget.focusNode!,
              500,
              (overlayEntry) {
                setState(
                  () {
                    _overlayEntry = overlayEntry;
                  },
                );
              },
            );
          }
          //when focus text field set value to the value
          //before make short with ellipse overflow
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
}
