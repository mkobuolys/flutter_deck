import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/drawer/flutter_deck_drawer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_drawer_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckDrawer', () {
    testWidgets('builds the drawer correctly', (tester) async {
      final mockRouter = MockFlutterDeckRouter();
      when(mockRouter.slides).thenReturn([]);
      final mockDeck = MockFlutterDeck();
      when(mockDeck.router).thenReturn(mockRouter);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: FlutterDeckProvider(
              flutterDeck: mockDeck,
              child: const FlutterDeckDrawer(),
            ),
          ),
        ),
      );

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.byType(FlutterDeckDrawer), findsOneWidget);
    });
  });
}
