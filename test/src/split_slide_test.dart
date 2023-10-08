import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

class SplitSlide extends FlutterDeckSlideWidget {
  const SplitSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/split-slide',
            footer: FlutterDeckFooterConfiguration(
              showSlideNumbers: true,
              showSocialHandle: true,
            ),
            header: FlutterDeckHeaderConfiguration(
              title: 'Split slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return Text('Here goes the LEFT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
      rightBuilder: (context) {
        return Text('Here goes the RIGHT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }
}

void main() {
  
  testWidgets('SplitSlide template test', (WidgetTester tester) async {
    await tester.pumpWidget(FlutterDeckApp(
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'John Doe',
        description: 'CEO of flutter_deck',
        socialHandle: '@john_doe',
        imagePath: '',
      ),
      slides: const[
        SplitSlide(),
        ],
      ),
    );

 
    final slideNumbersTextFinder = find.text('1');
    final socialHandleTextFinder = find.text('@john_doe');
    final headerFinder = find.text('Split slide template');
    final leftFinder = find.text(
      'Here goes the LEFT section content of the slide',
    );
    final leftStyle = tester.widget(leftFinder) as Text;
    final leftStyleTheme = FlutterDeckTheme.of(
      tester.element(leftFinder),).textTheme.bodyMedium;
    final rightFinder = find.text(
      'Here goes the RIGHT section content of the slide',
    );
    final rightStyle = tester.widget(rightFinder) as Text;
    final rightStyleTheme = FlutterDeckTheme.of(
      tester.element(rightFinder),).textTheme.bodyMedium;

    expect(leftStyle.style, leftStyleTheme);
    expect(rightStyle.style, rightStyleTheme);
    expect(slideNumbersTextFinder, findsOneWidget);
    expect(socialHandleTextFinder, findsOneWidget);
    expect(leftFinder, findsOneWidget);
    expect(rightFinder, findsOneWidget);
    expect(headerFinder, findsOneWidget);
  });
}
