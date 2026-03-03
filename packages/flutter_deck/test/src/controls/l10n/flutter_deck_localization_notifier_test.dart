import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/l10n/flutter_deck_localization_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckLocalizationNotifier', () {
    test('update should change value', () {
      final notifier = FlutterDeckLocalizationNotifier(
        locale: const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('es')],
      );

      expect(notifier.value, const Locale('en'));
      expect(notifier.supportedLocales.length, 2);

      notifier.update(const Locale('es'));

      expect(notifier.value, const Locale('es'));
    });
  });
}
