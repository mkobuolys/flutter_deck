import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- You can set the global theme for the whole deck.
- You can override the theme for a single slide.
''';

class ThemingSlide extends FlutterDeckSlideWidget {
  const ThemingSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/theming-slide',
          title: 'Theming',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Theming'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      theme: FlutterDeckTheme.of(context).copyWith(
        splitSlideTheme: const FlutterDeckSplitSlideThemeData(
          leftBackgroundColor: Colors.blue,
          leftColor: Colors.yellow,
          rightBackgroundColor: Colors.yellow,
          rightColor: Colors.blue,
        ),
      ),
      leftBuilder: (context) => Center(
        child: Text(
          'Global themes are great...\n\nThey keep your presentation looking '
          'consistent and professional.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.justify,
        ),
      ),
      rightBuilder: (context) => Center(
        child: Text(
          '...but slide-level themes let you break the rules!\n\n'
          'Just like this slide. It might not be UX friendly, but it proves '
          'a point.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
