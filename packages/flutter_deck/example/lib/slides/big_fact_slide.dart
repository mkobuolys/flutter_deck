import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The big fact slide is a template slide with a large title and a subtitle.
- You can customize the text styles and colors.
''';

class BigFactSlide extends FlutterDeckSlideWidget {
  const BigFactSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/big-fact',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Big fact slide template'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '100% Flutter',
      subtitle: 'Built from the ground up to leverage the framework you love.',
      theme: FlutterDeckTheme.of(context).copyWith(
        bigFactSlideTheme: const FlutterDeckBigFactSlideThemeData(titleTextStyle: TextStyle(color: Colors.amber)),
      ),
    );
  }
}
