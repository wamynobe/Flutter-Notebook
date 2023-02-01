//replace current text with shorter text by ellipsis overflow
import 'package:flutter/material.dart';
import 'package:keyboard_action/keyboard_action.dart';

double getReplaceIndex(
    TextStyle? style,
    int? maxLines,
    BoxConstraints constraints,
    BuildContext context,
    TextEditingController textController) {
  final span = TextSpan(
    style: style,
    text: textController.text,
  );
  if (checkTextFits(span, 1, maxLines, constraints)) {
    return -1;
  } else {
    final t = constraints.maxWidth / textDetails(context, 'a').width;
    return t;
  }
}

//get text size to count number of chars appear on the screen
Size textDetails(BuildContext context, String char) {
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

String getOverFlowText({required String value, required double index}) {
  if (value.length <= index) {
    return value;
  }
  final newValue = value.substring(0, index.ceil() - 2);
  return '$newValue...';
}

//check if text is fit the text box or not
bool checkTextFits(
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

Widget? showOverlay(BuildContext context, OverlayEntry? overlayEntry,
    FocusNode focus, int duration, Function(OverlayEntry?) onShowed) {
  if (overlayEntry != null) {
    return null;
  } else {
    var myDuration = 500;
    final overlayState = Overlay.of(context);
    final newOverlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedPositioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          duration: Duration(milliseconds: myDuration),
          curve: Curves.easeOutQuad,
          child: KeyboardModifier(
            focus: focus,
          ),
        );
      },
    );
    onShowed(newOverlayEntry);
    overlayState?.insert(newOverlayEntry);
  }
}

void removeOverlay(OverlayEntry? overlayEntry, Function onRemove) {
  if (overlayEntry != null) {
    overlayEntry.remove();
    onRemove();
  }
}
