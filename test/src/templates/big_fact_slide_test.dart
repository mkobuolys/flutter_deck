import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utils.dart';

void main() {
  group('BigFactSlide', () {
    testWidgets('should render all layout elements', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const BigFactSlide(),
      );

      await slideTester.pumpSlide();

      final socialHandleFinder = find.text('@flutter_deck');
      final headerFinder = find.text('Slide');
      final slideNumberFinder = find.text('1');
      final bigFactFinder = find.text('100%');
      final descriptionFinder = find.text('The test coverage value');

      expect(socialHandleFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
      expect(slideNumberFinder, findsOneWidget);
      expect(bigFactFinder, findsOneWidget);
      expect(descriptionFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const BigFactSlide(),
      );

      await slideTester.pumpSlide();

      final sliderFinder = find.byKey(const Key('BigFactslide'));
      final slider = tester.widget(sliderFinder) as FlutterDeckSlide;
      final textStyleFinder = slider.theme!.bigFactSlideTheme.titleTextStyle!;
      final textStyleColor = textStyleFinder.color;

      expect(textStyleColor, equals(Colors.amber));
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const BigFactSlide(),
        );

        await slideTester.pumpSlide();

        final socialHandleFinder = find.text('@flutter_deck');
        final headerFinder = find.text('Slide template');
        final slideNumberFinder = find.text('1');
        final bigFactFinder = find.text('100%');
        final descriptionFinder = find.text('The test coverage value');

        expect(socialHandleFinder, findsNothing);
        expect(headerFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(bigFactFinder, findsOneWidget);
        expect(descriptionFinder, findsOneWidget);
      });
    });
  });
}

class BigFactSlide extends FlutterDeckSlideWidget {
  const BigFactSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/big-fact',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '100%',
      subtitle: 'The test coverage value',
      theme: FlutterDeckTheme.of(context).copyWith(
        bigFactSlideTheme: const FlutterDeckBigFactSlideThemeData(
          titleTextStyle: TextStyle(color: Colors.amber),
        ),
      ),
      key: const Key('BigFactslide'),
    );
  }
}
