---
title: Quote Slide
navOrder: 4
---

To create a quote slide, use the `FlutterDeckSlide.quote` constructor. It is responsible for rendering the quote and attribution below it.

```dart
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
  Widget build(BuildContext context) {
    return FlutterDeckSlide.quote(
      quote: '"If you really look closely, most overnight successes took a long time."',
      attribution: '- Steve Jobs',
      theme: FlutterDeckTheme.of(context).copyWith(
        quoteSlideTheme: const FlutterDeckQuoteSlideThemeData(
          quoteTextStyle: TextStyle(color: Colors.yellowAccent),
        ),
      ),
    );
  }
}
```

![Quote slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/quote.png?raw=true)
