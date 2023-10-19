import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utils.dart';

void main() {
  group('BlankSlide', () {
    testWidgets('should render all layout elements',
        (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const BlankSlide(),
      );

      await slideTester.pumpSlide();

      final titleFinder = find.text('Slide');
      final slideNumberFinder = find.text('1');
      final socialHandleFinder = find.text('@flutter_deck');
      final contentFinder = find.text('Test Content');

      expect(titleFinder, findsOneWidget);
      expect(slideNumberFinder, findsOneWidget);
      expect(socialHandleFinder, findsOneWidget);
      expect(contentFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const BlankSlide(),
      );

      await slideTester.pumpSlide();

      final sliderFinder = find.byKey(const Key('blankslide'));
      final slider = tester.widget(sliderFinder) as FlutterDeckSlide;
      final backgroundColor = slider.theme?.slideTheme.backgroundColor;

      expect(backgroundColor, equals(Colors.orange));
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const BlankSlide(),
        );

        await slideTester.pumpSlide();

        final titleFinder = find.text('Slide');
        final slideNumberFinder = find.text('1');
        final socialHandleFinder = find.text('@flutter_deck');
        final contentFinder = find.text('Test Content');

        expect(titleFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(socialHandleFinder, findsNothing);
        expect(contentFinder, findsOneWidget);
      });
    });
  });
}

class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Text('Test Content'),
      theme: FlutterDeckTheme.of(context).copyWith(
        slideTheme: const FlutterDeckSlideThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      key: const Key('blankslide'),
    );
  }
}
