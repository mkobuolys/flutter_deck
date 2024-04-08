import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- Welcome to flutter_deck example! 🚀
- Use slide deck controls to navigate.
''';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/intro',
            title: 'Welcome to flutter_deck',
            speakerNotes: _speakerNotes,
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Welcome to flutter_deck example! 🚀',
      subtitle: 'Use slide deck controls to navigate.',
    );
  }
}
