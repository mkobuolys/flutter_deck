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
            header: FlutterDeckHeaderConfiguration(
              title: 'Big fact slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    const title = '100%';
    const subtitle = 'The test coverage value that flutter_deck will probably '
        'never achieve';

    return FlutterDeckSlide.bigFact(
      title: title,
      subtitle: subtitle,
      theme: FlutterDeckTheme.of(context).copyWith(
        bigFactSlideTheme: const FlutterDeckBigFactSlideThemeData(
          titleTextStyle: TextStyle(color: Colors.amber),
        ),
      ),
    );
  }
}
