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
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: FlutterDeckCodeHighlightTheme(
          data: FlutterDeckCodeHighlightTheme.of(context).copyWith(
            textStyle: FlutterDeckTheme.of(context).textTheme.bodySmall,
          ),
          child: const FlutterDeckCodeHighlight(
            code: '''
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
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: Text('Use FlutterDeckCodeHighlight widget to highlight code!'),
      ),
    );
  }
}''',
            fileName: 'code_highlight_slide.dart',
            language: 'dart',
          ),
        ),
      ),
    );
  }
}
