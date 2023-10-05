import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

class ImageSlide extends FlutterDeckSlideWidget {
  const ImageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/image-slide',
            footer: FlutterDeckFooterConfiguration(
              showSlideNumbers: true,
              showSocialHandle: true,
            ),
            header: FlutterDeckHeaderConfiguration(
              title: 'Image slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset('assets/header.png'),
      label: 'Here goes the label of the image (optional)',
      backgroundBuilder: (context) => Container(
        color: Colors.blue, 
      ),
    );
  }
}

void main() {
  
  testWidgets('ImageSlide template test', (WidgetTester tester) async {
    await tester.pumpWidget(FlutterDeckApp(
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'John Doe',
        description: 'CEO of flutter_deck',
        socialHandle: '@john_doe',
        imagePath: '',
      ),
      slides: const[
        ImageSlide(),
        ],
    ),
  );

  final slideNumbersTextFinder = find.text('1');
  final socialHandleTextFinder = find.text('@john_doe');
  final labelFinder = find.text('Here goes the label of the image (optional)');
  final headerFinder = find.text('Image slide template');
  final imageFinder = find.byType(Image);
  

// final backgroundFinder = find.byKey(const Key('custom_background'));
// final container = tester.widget<Container>(backgroundFinder);
// final decoration = container.decoration! as BoxDecoration;
// expect(backgroundFinder, findsOneWidget);
// expect(decoration.color, equals(Colors.blue));
  expect(slideNumbersTextFinder, findsOneWidget);
  expect(socialHandleTextFinder, findsOneWidget);
  expect(labelFinder, findsOneWidget);
  expect(headerFinder, findsOneWidget);
  expect(imageFinder,findsOneWidget);
  });
}
