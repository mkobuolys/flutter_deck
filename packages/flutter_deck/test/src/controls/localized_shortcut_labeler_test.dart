import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/src/controls/localized_shortcut_labeler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalizedShortcutLabeler', () {
    testWidgets('getShortcutLabel uses default labeler logic', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('A'))));
      final context = tester.element(find.byType(Scaffold));
      final localizations = MaterialLocalizations.of(context);

      final labeler = LocalizedShortcutLabeler.instance;
      final label = labeler.getShortcutLabel(const SingleActivator(LogicalKeyboardKey.keyA, control: true), localizations);

      expect(label, isNotEmpty);
    });
  });
}
