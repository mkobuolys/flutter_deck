import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- This slide is hidden. Oh, but you can't see it...
''';

class HiddenSlide extends FlutterDeckSlideWidget {
  const HiddenSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/hidden',
            speakerNotes: _speakerNotes,
            hidden: true,
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          "This slide is hidden. Oh, but you can't see it...",
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
