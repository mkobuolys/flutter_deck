import 'package:flutter_deck/src/widgets/internal/drawer/flutter_deck_drawer_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckDrawerNotifier', () {
    test('toggle should notify listeners', () {
      final notifier = FlutterDeckDrawerNotifier();

      var listenerCalled = false;

      notifier
        ..addListener(() => listenerCalled = true)
        ..toggle();

      expect(listenerCalled, isTrue);
    });
  });
}
