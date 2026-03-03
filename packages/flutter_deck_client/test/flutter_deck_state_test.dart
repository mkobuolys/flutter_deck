import 'package:flutter_deck_client/flutter_deck_client.dart';
import 'package:test/test.dart';

void main() {
  group('FlutterDeckState', () {
    test('fromJson and toJson', () {
      final state = const FlutterDeckState(
        locale: 'en',
        themeMode: 'dark',
        markerEnabled: true,
        slideIndex: 2,
        slideStep: 3,
      );

      final json = state.toJson();
      final newState = FlutterDeckState.fromJson(json);

      expect(newState, equals(state));
      expect(newState.hashCode, equals(state.hashCode));
          final newState2 = state.copyWith(slideIndex: 10, slideStep: 5);
      expect(newState2.slideIndex, equals(10));
      expect(newState2.slideStep, equals(5));
    });


    test('copyWith', () {
      final state = const FlutterDeckState(
        locale: 'en',
        themeMode: 'dark',
      );

      final newState = state.copyWith(locale: 'es', markerEnabled: true);

      expect(newState.locale, equals('es'));
      expect(newState.themeMode, equals('dark'));
      expect(newState.markerEnabled, isTrue);
      expect(newState.slideIndex, equals(0));
      expect(newState.slideStep, equals(1));
    });
  });
}
