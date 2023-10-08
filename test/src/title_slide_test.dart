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
      title: 'Here goes the title',
      subtitle: 'Here goes the subtitle',
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

void main() {
  
  testWidgets('TitleSlide template test', (WidgetTester tester) async {
    await tester.pumpWidget(FlutterDeckApp(
      slides: const[
        TitleSlide(),
      ],
     ),
    );

    final footerFinder = find.byType(FlutterDeckFooter);
    final titleFinder = find.text('Here goes the title');
    final subtitleFinder = find.text('Here goes the subtitle');
    final containerFinder = find.byKey(const Key('Deck Background'));
    final container = tester.widget(containerFinder) as Container;
    final deckBackgroundColor = container.color;
    
    expect(deckBackgroundColor, equals(Colors.orange));
    expect(titleFinder, findsOneWidget);
    expect(subtitleFinder, findsOneWidget);
    expect(footerFinder,findsNothing);
  });
}
