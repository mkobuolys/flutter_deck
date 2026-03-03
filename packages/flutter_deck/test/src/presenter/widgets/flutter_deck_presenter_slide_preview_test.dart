import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_slide_preview.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_presenter_slide_preview_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckPresenterSlidePreview', () {
    late MockFlutterDeckRouter mockRouter;
    late MockFlutterDeck mockDeck;

    setUp(() {
      mockRouter = MockFlutterDeckRouter();
      mockDeck = MockFlutterDeck();

      when(mockRouter.currentSlideIndex).thenReturn(0);
      when(mockRouter.currentStep).thenReturn(1);
      when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/1', steps: 2));
      when(mockRouter.slides).thenReturn([
        const FlutterDeckRouterSlide(
          route: '/1',
          widget: SizedBox(),
          configuration: FlutterDeckSlideConfiguration(route: '/1'),
        ),
        const FlutterDeckRouterSlide(
          route: '/2',
          widget: SizedBox(),
          configuration: FlutterDeckSlideConfiguration(route: '/2'),
        ),
      ]);
      when(mockDeck.router).thenReturn(mockRouter);
      when(mockDeck.globalConfiguration).thenReturn(const FlutterDeckConfiguration());
    });

    testWidgets('builds slide preview headers correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckProvider(flutterDeck: mockDeck, child: FlutterDeckPresenterSlidePreview()),
            ),
          ),
        ),
      );

      expect(find.text('Current: Slide 1 of 2 (step 1 of 2)'), findsOneWidget);
      expect(find.text('Next: Slide 2 of 2'), findsOneWidget);
    });
  });
}
