import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckThemeNotifier', () {
    test('should update value', () {
      final notifier = FlutterDeckThemeNotifier(ThemeMode.light);

      expect(notifier.value, ThemeMode.light);

      notifier.update(ThemeMode.dark);

      expect(notifier.value, ThemeMode.dark);
    });
  });
}
