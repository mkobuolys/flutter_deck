import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_slide_steps_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckSlideSteps', () {
    late MockFlutterDeck mockDeck;
    late MockFlutterDeckRouter mockRouter;

    setUp(() {
      mockDeck = MockFlutterDeck();
      mockRouter = MockFlutterDeckRouter();

      when(mockRouter.currentStep).thenReturn(1);
      when(mockRouter.currentSlideIndex).thenReturn(0);
      when(mockDeck.router).thenReturn(mockRouter);
      when(mockDeck.stepNumber).thenAnswer((_) => mockRouter.currentStep);
      when(mockDeck.slideNumber).thenAnswer((_) => mockRouter.currentSlideIndex + 1);
    });

    testWidgets('builder and listener build properly', (tester) async {
      final routerListeners = <VoidCallback>[];
      when(mockRouter.addListener(any)).thenAnswer((invocation) {
        routerListeners.add(invocation.positionalArguments[0]);
      });

      var listenerCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: mockDeck,
            child: Scaffold(
              body: FlutterDeckSlideStepsListener(
                listener: (context, step) {
                  listenerCalled = true;
                },
                child: FlutterDeckSlideStepsBuilder(builder: (context, step) => Text('Step $step')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Step 1'), findsOneWidget);
      expect(listenerCalled, isFalse);

      when(mockRouter.currentStep).thenReturn(2);
      for (final listener in routerListeners) {
        listener();
      }

      await tester.pumpAndSettle();

      expect(find.text('Step 2'), findsOneWidget);
      expect(listenerCalled, isTrue);
    });
  });
}
