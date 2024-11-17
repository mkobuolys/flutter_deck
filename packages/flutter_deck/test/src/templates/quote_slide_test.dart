import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

const _attribution = '- Author';
const _quote = 'Quote text';
const _key = Key('QuoteSlide');

void main() {
  group('QuoteSlide', () {
    testWidgets('should render all layout elements', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const QuoteSlide(),
      );

      await slideTester.pumpSlide();

      final socialHandleFinder = find.text('@flutter_deck');
      final headerFinder = find.text('Slide');
      final slideNumberFinder = find.text('1');
      final quoteFinder = find.text(_quote);
      final attributionFinder = find.text(_attribution);

      expect(socialHandleFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
      expect(slideNumberFinder, findsOneWidget);
      expect(quoteFinder, findsOneWidget);
      expect(attributionFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const QuoteSlide(),
      );

      await slideTester.pumpSlide();

      final slideFinder = find.byKey(_key);
      final slide = tester.widget(slideFinder) as FlutterDeckSlide;
      final textStyleFinder = slide.theme!.quoteSlideTheme.quoteTextStyle!;
      final textStyleColor = textStyleFinder.color;

      expect(textStyleColor, equals(Colors.yellowAccent));
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const QuoteSlide(),
        );

        await slideTester.pumpSlide();

        final titleFinder = find.text('Slide');
        final slideNumberFinder = find.text('1');
        final socialHandleFinder = find.text('@flutter_deck');
        final quoteFinder = find.text(_quote);
        final attributionFinder = find.text(_attribution);

        expect(titleFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(socialHandleFinder, findsNothing);
        expect(quoteFinder, findsOneWidget);
        expect(attributionFinder, findsOneWidget);
      });
    });
  });
}

class QuoteSlide extends FlutterDeckSlideWidget {
  const QuoteSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/quote',
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.quote(
      quote: _quote,
      attribution: _attribution,
      theme: FlutterDeckTheme.of(context).copyWith(
        quoteSlideTheme: const FlutterDeckQuoteSlideThemeData(
          quoteTextStyle: TextStyle(color: Colors.yellowAccent),
        ),
      ),
      key: _key,
    );
  }
}
