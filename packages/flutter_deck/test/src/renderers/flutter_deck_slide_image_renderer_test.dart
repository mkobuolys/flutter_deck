import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/renderers/flutter_deck_slide_image_renderer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'flutter_deck_slide_image_renderer_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>()])
void main() {
  group('FlutterDeckSlideImageRenderer', () {
    test('default instantiation', () {
      final mockFlutterDeck = MockFlutterDeck();
      final renderer = FlutterDeckSlideImageRenderer(flutterDeck: mockFlutterDeck);
      expect(renderer, isNotNull);
    });
  });
}
