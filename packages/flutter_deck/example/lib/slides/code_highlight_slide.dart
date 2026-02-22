import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- Use FlutterDeckCodeHighlight widget to highlight code.
- It supports multiple programming languages.
- You can customize the text style and background color.
''';

class CodeHighlightSlide extends FlutterDeckSlideWidget {
  const CodeHighlightSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/code-highlight',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Code Highlighting'),
          steps: 3,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: FlutterDeckSlideStepsBuilder(
          builder: (context, stepNumber) {
            String codeCode;
            var highlightedLines = <int>[];

            if (stepNumber == 1) {
              codeCode = '''
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckSlideWidget {
  const CodeHighlightSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            header: FlutterDeckHeaderConfiguration(title: 'Code Highlighting'),
          ),
        );
}''';
            } else if (stepNumber == 2) {
              codeCode = '''
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckSlideWidget {
  const CodeHighlightSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            header: FlutterDeckHeaderConfiguration(title: 'Code Highlighting'),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: Text('Use FlutterDeckCodeHighlight widget to highlight code!'),
      ),
    );
  }
}''';
              highlightedLines = [12, 13, 14, 15, 16, 17, 18, 19, 20];
            } else {
              codeCode = '''
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckSlideWidget {
  const CodeHighlightSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            header: FlutterDeckHeaderConfiguration(title: 'Code Highlighting'),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: Text('Enjoy code animations!'),
      ),
    );
  }
}''';
              highlightedLines = [16];
            }

            return FlutterDeckCodeHighlightTheme(
              data: FlutterDeckCodeHighlightTheme.of(
                context,
              ).copyWith(textStyle: FlutterDeckTheme.of(context).textTheme.bodySmall),
              child: FlutterDeckCodeHighlight(
                code: codeCode,
                fileName: 'code_highlight_slide.dart',
                language: 'dart',
                highlightedLines: highlightedLines,
              ),
            );
          },
        ),
      ),
    );
  }
}
