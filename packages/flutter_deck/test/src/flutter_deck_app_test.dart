import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckApp', () {
    group('when slides list is empty', () {
      test('should throw [AssertionError]', () {
        expect(
          () => FlutterDeckApp(slides: const []),
          throwsA(isA<AssertionError>().having((e) => e.message, 'message', 'You must provide at least one slide')),
        );
      });
    });
  });
}
