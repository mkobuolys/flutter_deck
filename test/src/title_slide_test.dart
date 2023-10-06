import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title-slide',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Here goes the title of the slide',
      subtitle: 'Here goes the subtitle of the slide (optional',
    );
  }
}

void main() {
  
  testWidgets('TitleSlide template test', (WidgetTester tester) async {
    await tester.pumpWidget(FlutterDeckApp(
      slides: const[
        TitleSlide(),
        ],
    ),
  );

  final footerFinder = find.byType(FlutterDeckFooter);
  final titleFinder = find.text('Here goes the title of the slide',);
  final subtitleFinder = find.text(
    'Here goes the subtitle of the slide (optional',
  );

  expect(titleFinder, findsOneWidget);
  expect(subtitleFinder, findsOneWidget);
  expect(footerFinder,findsNothing);
  });
}
