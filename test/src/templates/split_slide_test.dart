import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_utils.dart';

void main() {
  group('SplitSlide', () {
    testWidgets('should render all layout elements',
        (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const SplitSlide(),
      );

      await slideTester.pumpSlide();

      final titleFinder = find.text('Slide');
      final slideNumberFinder = find.text('1');
      final socialHandleFinder = find.text('@flutter_deck');
      final leftFinder = find.text(
        'Here goes the LEFT section content of the slide',
      );
      final rightFinder = find.text(
        'Here goes the RIGHT section content of the slide',
      );

      expect(leftFinder, findsOneWidget);
      expect(rightFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(slideNumberFinder, findsOneWidget);
      expect(socialHandleFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const SplitSlide(),
      );

      await slideTester.pumpSlide();

      final leftFinder = find.text(
        'Here goes the LEFT section content of the slide',
      );
      final leftText = tester.widget(leftFinder) as Text;
      final leftStyleTheme = FlutterDeckTheme.of(
        tester.element(leftFinder),
      ).textTheme.bodyMedium;

      final rightFinder = find.text(
        'Here goes the RIGHT section content of the slide',
      );
      final rightText = tester.widget(rightFinder) as Text;
      final rightStyleTheme = FlutterDeckTheme.of(
        tester.element(rightFinder),
      ).textTheme.bodyMedium;

      expect(leftText.style, leftStyleTheme);
      expect(rightText.style, rightStyleTheme);
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const SplitSlide(),
        );

        await slideTester.pumpSlide();

        final titleFinder = find.text('Slide');
        final slideNumberFinder = find.text('1');
        final socialHandleFinder = find.text('@flutter_deck');

        expect(titleFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(socialHandleFinder, findsNothing);
      });
    });
  });
}

class SplitSlide extends FlutterDeckSlideWidget {
  const SplitSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/split-slide',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return Text(
          'Here goes the LEFT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
      rightBuilder: (context) {
        return Text(
          'Here goes the RIGHT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }
}
