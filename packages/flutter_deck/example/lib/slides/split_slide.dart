import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The split slide template renders two columns, one on the left and one on right.
- You can change the split ratio based on your needs.
''';

class SplitSlide extends FlutterDeckSlideWidget {
  const SplitSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/split-slide',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Split slide template'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) =>
          Center(child: Text('Why choose one thing...', style: FlutterDeckTheme.of(context).textTheme.title)),
      rightBuilder: (context) => Center(
        child: Text(
          '...when you can have two?\n\nSplit slides make comparisons a breeze.',
          style: FlutterDeckTheme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
