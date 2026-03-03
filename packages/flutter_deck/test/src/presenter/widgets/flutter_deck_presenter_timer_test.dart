import 'package:flutter/material.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckPresenterTimer', () {
    testWidgets('builds timer', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: FlutterDeckPresenterTimer())));

      expect(find.byType(FlutterDeckPresenterTimer), findsOneWidget);
    });
  });
}
