import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/l10n/flutter_deck_localization_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckLocalizationNotifier', () {
    test('update should change value', () {
      const localeEn = Locale('en');
      const localeEs = Locale('es');

      final notifier = FlutterDeckLocalizationNotifier(locale: localeEn, supportedLocales: const [localeEn, localeEs]);

      expect(notifier.value, localeEn);
      expect(notifier.supportedLocales.length, 2);

      notifier.update(localeEs);

      expect(notifier.value, localeEs);
    });
  });
}
