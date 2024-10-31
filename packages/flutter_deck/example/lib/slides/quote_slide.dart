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
            header: FlutterDeckHeaderConfiguration(
              title: 'Quote slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    const quote = '"If you really look closely, most overnight successes '
        'took a long time."';
    const attribution = '- Steve Jobs';

    return FlutterDeckSlide.quote(
      quote: quote,
      attribution: attribution,
      theme: FlutterDeckTheme.of(context).copyWith(
        quoteSlideTheme: const FlutterDeckQuoteSlideThemeData(
          quoteTextStyle: TextStyle(color: Colors.yellowAccent),
        ),
      ),
    );
  }
}
