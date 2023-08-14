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
      builder: (context) => Center(
        child: FlutterDeckCodeHighlight(
          code: '''
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckBlankSlide {
  const CodeHighlightSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            header: FlutterDeckHeaderConfiguration(title: 'Code Highlighting'),
          ),
        );

  @override
  Widget body(BuildContext context) {
    return const Center(
      child: Text('Use FlutterDeckCodeHighlight widget to highlight code!'),
    );
  }
}''',
          fileName: 'code_highlight_slide.dart',
          language: 'dart',
          textStyle: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
