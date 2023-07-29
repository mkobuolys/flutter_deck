import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class CodeHighlightSlide extends FlutterDeckBlankSlide {
  const CodeHighlightSlide({
    super.key,
  }) : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/code-highlight',
            header: FlutterDeckHeaderConfiguration(
              title: 'Code Highlighting',
            ),
          ),
        );

  @override
  Widget body(BuildContext context) => const Center(
        child: FlutterDeckCodeHighlight(
          code: '''
import 'package:flutter_deck/flutter_deck.dart';

class TitleSlide extends FlutterDeckTitleSlide {
  const TitleSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/intro',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  String get title => 'Welcome to flutter_deck example! 🚀';

  @override
  String? get subtitle => 'Use left and right arrow keys to navigate.';
}''',
          fileName: 'title_slide.dart',
          language: 'dart',
        ),
      );
}
