import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_slide_steps_builder.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_slide_steps_listener.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_slide_steps_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckSlideSteps', () {
    testWidgets('builder and listener build properly', (tester) async {
      final mockRouter = MockFlutterDeckRouter();
      when(mockRouter.currentStep).thenReturn(1);
      final flutterDeck = MockFlutterDeck();
      when(flutterDeck.router).thenReturn(mockRouter);

      var listenerCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: Scaffold(
              body: FlutterDeckSlideStepsListener(
                listener: (context, step) {
                  listenerCalled = true;
                },
                child: FlutterDeckSlideStepsBuilder(builder: (context, step) => const Text(r'Step $step')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Step 1'), findsNothing);

      when(mockRouter.currentStep).thenReturn(2);

      await tester.pumpAndSettle();

      expect(find.text('Step 2'), findsOneWidget);
      expect(listenerCalled, isTrue);
    });
  });
}
