import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_speaker_notes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_speaker_notes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckSpeakerNotes', () {
    testWidgets('builds notes', (tester) async {
      final mockRouter = MockFlutterDeckRouter();
      when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/1', speakerNotes: 'test note'));
      final flutterDeck = MockFlutterDeck();
      when(flutterDeck.router).thenReturn(mockRouter);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterDeckProvider(
              flutterDeck: flutterDeck,
              child: const FlutterDeckSpeakerNotes(),
            ),
          ),
        ),
      );
      expect(find.byType(FlutterDeckSpeakerNotes), findsOneWidget);
      expect(find.text('test note'), findsOneWidget);
    });
  });
}
