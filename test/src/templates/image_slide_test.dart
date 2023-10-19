import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_utils.dart';

void main() {
  group('ImageSlide', () {
    testWidgets('should render all layout elements',
        (WidgetTester tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: true,
        showFooter: true,
        slide: const ImageSlide(),
      );
      await slideTester.pumpSlide();
      final titleFinder = find.text('Slide');
      final labelFinder = find.text('Here goes the label of the image');
      final slideNumberFinder = find.text('1');
      final socialHandleFinder = find.text('@flutter_deck');
      final imageFinder = find.byKey(const Key('Image Key'));

      expect(imageFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);
      expect(slideNumberFinder, findsOneWidget);
      expect(socialHandleFinder, findsOneWidget);
    });

    testWidgets('should apply theming', (WidgetTester tester) async {
      final slideTester = SlideTester(
        tester: tester,
        showHeader: false,
        showFooter: false,
        slide: const ImageSlide(),
      );
      await slideTester.pumpSlide();
      final containerFinder = find.byKey(const Key('Container Key'));
      final container = tester.widget(containerFinder) as Container;
      final backgroundColor = container.color;

      expect(backgroundColor, equals(Colors.orange));
    });

    group('when footer and header are disabled', () {
      testWidgets('should render content only', (WidgetTester tester) async {
        final slideTester = SlideTester(
          tester: tester,
          showHeader: false,
          showFooter: false,
          slide: const ImageSlide(),
        );
        await slideTester.pumpSlide();
        final titleFinder = find.text('Slide');
        final slideNumberFinder = find.text('1');
        final socialHandleFinder = find.text('@flutter_deck');
        final imageFinder = find.byKey(const Key('Image Key'));

        expect(imageFinder, findsOneWidget);
        expect(titleFinder, findsNothing);
        expect(slideNumberFinder, findsNothing);
        expect(socialHandleFinder, findsNothing);
      });
    });
  });
}

class ImageSlide extends FlutterDeckSlideWidget {
  const ImageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/image-slide',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset('assets/header.png'),
      key: const Key('Image Key'),
      label: 'Here goes the label of the image',
      backgroundBuilder: (context) => Container(
        color: Colors.orange,
        key: const Key('Container Key'),
      ),
    );
  }
}
