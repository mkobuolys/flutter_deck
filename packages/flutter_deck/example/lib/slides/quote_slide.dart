import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class QuoteSlide extends FlutterDeckSlideWidget {
  const QuoteSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/quote',
            header: FlutterDeckHeaderConfiguration(
              title: 'Quote slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.quote(
      quote:
          '"If you really look closely, most overnight successes took a long time."',
      attribution: '- Steve Jobs',
      theme: FlutterDeckTheme.of(context).copyWith(
        quoteSlideTheme: const FlutterDeckQuoteSlideThemeData(
          quoteTextStyle: TextStyle(color: Colors.yellowAccent),
        ),
      ),
    );
  }
}
