import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_marker_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckConfiguration>()])
void main() {
  group('FlutterDeckMarker', () {
    late MockFlutterDeck mockDeck;
    late MockFlutterDeckConfiguration mockConfig;

    const route = '/test';

    setUp(() {
      mockDeck = MockFlutterDeck();
      mockConfig = MockFlutterDeckConfiguration();

      when(mockConfig.marker).thenReturn(const FlutterDeckMarkerConfiguration());
      when(mockDeck.globalConfiguration).thenReturn(mockConfig);
      when(mockDeck.configuration).thenReturn(const FlutterDeckSlideConfiguration(route: route));
    });

    testWidgets('builds when enabled and draws on canvas', (tester) async {
      final notifier = FlutterDeckMarkerNotifier()..toggle();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterDeckProvider(
              flutterDeck: mockDeck,
              child: FlutterDeckMarker(notifier: notifier, child: const SizedBox(width: 100, height: 100)),
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);

      final gestureDetector = find.byType(GestureDetector).first;

      await tester.tap(gestureDetector);
      await tester.pumpAndSettle();
    });

    testWidgets('does not build gesture detector when disabled', (tester) async {
      final notifier = FlutterDeckMarkerNotifier();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterDeckProvider(
              flutterDeck: mockDeck,
              child: FlutterDeckMarker(notifier: notifier, child: const SizedBox(width: 100, height: 100)),
            ),
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets('keeps drawn paths visible when disabled', (tester) async {
      // Draw a path for the slide, then leave the marker disabled.
      final notifier = FlutterDeckMarkerNotifier()
        ..update(route, 0, const Offset(10, 10))
        ..update(route, 0, const Offset(20, 20));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlutterDeckProvider(
              flutterDeck: mockDeck,
              child: FlutterDeckMarker(notifier: notifier, child: const SizedBox(width: 100, height: 100)),
            ),
          ),
        ),
      );

      // The drawing is still painted, but no gesture detector captures input.
      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.byType(GestureDetector), findsNothing);
    });
  });
}
