import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The blank slide template renders a header and a footer.
- The remaining space is free for your imagination.
''';

class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/blank-slide',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Blank slide template'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'The canvas is yours 🎨\n\n'
          'With a blank slide, your imagination is the limit.\n'
          "It's just a Flutter widget, go wild!",
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
