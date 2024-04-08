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
  FlutterDeckSlide build(BuildContext context) {
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
          'You can set the global theme for the whole deck by specifying '
          'lightTheme and darkTheme properties in the FlutterDeckApp widget.',
          style: FlutterDeckTheme.of(context)
              .textTheme
              .bodyMedium
              .copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.justify,
        ),
      ),
      rightBuilder: (context) => Center(
        child: Text(
          'You can also override the theme for a single slide by specifying '
          'the theme property in the FlutterDeckSlide widget. It will be '
          'merged with the global theme (only the properties you specify will '
          'be overridden).\n\nJust like in this slide. Not UX friendly, but '
          'you get the idea.',
          style: FlutterDeckTheme.of(context)
              .textTheme
              .bodyMedium
              .copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
