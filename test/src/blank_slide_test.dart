import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
            footer: FlutterDeckFooterConfiguration(
              showSlideNumbers: true,
              showSocialHandle: true,
            ),
            header: FlutterDeckHeaderConfiguration(
              title: 'Blank slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Text('Here goes the content of the slide'),
      theme: FlutterDeckTheme.of(context).copyWith(
        slideTheme: const FlutterDeckSlideThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      key: const Key('blankslide'),
    );
  }
}

void main() {
  
  testWidgets('BlankSlide template test', (WidgetTester tester) async {
    await tester.pumpWidget(FlutterDeckApp(
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'John Doe',
        description: 'CEO of flutter_deck',
        socialHandle: '@john_doe',
        imagePath: '',
      ),
      slides: const[
        BlankSlide(),
        ],
    ),
  );

  final slideNumbersTextFinder = find.text('1');
  final socialHandleTextFinder = find.text('@john_doe');
  final headerFinder = find.text('Blank slide template');
  final contentFinder = find.text('Here goes the content of the slide');

  
  final slideFinder = find.byKey(const Key('blankslide'));
  final slide = tester.widget(slideFinder) as FlutterDeckSlide;
  final backgroundColor = slide.theme?.slideTheme.backgroundColor;

  expect(backgroundColor, equals(Colors.orange));
  expect(slideNumbersTextFinder, findsOneWidget);
  expect(socialHandleTextFinder, findsOneWidget);
  expect(headerFinder, findsOneWidget);
  expect(contentFinder, findsOneWidget);
  });
}
