import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- This slide is hidden. Oh, but you can't see it...
''';

class HiddenSlide extends FlutterDeckSlideWidget {
  const HiddenSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(route: '/hidden', speakerNotes: _speakerNotes, hidden: true),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Shhh... this slide is a secret! 🤫\n\nYou can hide slides from '
          'the main presentation flow, but still link to them.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
