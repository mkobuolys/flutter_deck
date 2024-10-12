import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The blank slide template renders a header and a footer.
- The remaining space is free for your imagination.
''';

class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
            speakerNotes: _speakerNotes,
            header: FlutterDeckHeaderConfiguration(
              title: 'Blank slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Based on the configuration, this template renders a header and a '
          'footer.\nThe remaining space is free for your imagination.',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
