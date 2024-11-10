import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  group('TitleSlide', () {
    testWidgets('should render all layout elements', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const TitleSlide(),
      );

      await slideTester.pumpSlide();

      final socialHandleFinder = find.text('@flutter_deck');
      final headerFinder = find.text('Slide');
      final titleFinder = find.text('Title');
      final subtitleFinder = find.text('Subtitle');
      final slideNumberFinder = find.text('1');
      final socialHandleWidgets = tester.widgetList(socialHandleFinder);

      expect(socialHandleWidgets.length, equals(2));
      expect(slideNumberFinder, findsOneWidget);
      expect(headerFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(subtitleFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const TitleSlide(),
      );

      await slideTester.pumpSlide();

      final containerFinder = find.byKey(const Key('Deck Background'));
      final container = tester.widget(containerFinder) as Container;
      final deckBackgroundColor = container.color;

      expect(deckBackgroundColor, equals(Colors.orange));
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const TitleSlide(),
        );

        await slideTester.pumpSlide();

        final headerFinder = find.text('Slide');
        final slideNumberFinder = find.text('1');
        final titleFinder = find.text('Title');
        final subtitleFinder = find.text('Subtitle');
        final socialHandleInfo = find.text('@flutter_deck');

        expect(socialHandleInfo, findsOneWidget);
        expect(headerFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(titleFinder, findsOneWidget);
        expect(subtitleFinder, findsOneWidget);
      });
    });
  });
}

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title-slide',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Title',
      subtitle: 'Subtitle',
      backgroundBuilder: (context) => FlutterDeckBackground.custom(
        child: Container(
          color: Colors.orange,
          key: const Key('Deck Background'),
        ),
      ),
      key: const Key('title slide'),
    );
  }
}
