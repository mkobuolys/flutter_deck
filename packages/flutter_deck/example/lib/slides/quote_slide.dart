import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The quote slide template renders a quote and an attribution.
- You can change the text styles and colors.
''';

class QuoteSlide extends FlutterDeckSlideWidget {
  const QuoteSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/quote',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Quote slide template'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const quote = '"I used to hate making slides. Now I just write Flutter code!"';
    const attribution = '- Every Flutter developer ever';

    return FlutterDeckSlide.quote(
      quote: quote,
      attribution: attribution,
      theme: FlutterDeckTheme.of(context).copyWith(
        quoteSlideTheme: const FlutterDeckQuoteSlideThemeData(quoteTextStyle: TextStyle(color: Colors.yellowAccent)),
      ),
    );
  }
}
