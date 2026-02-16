import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/flutter_deck_text_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckTextTheme', () {
    test('should have correct default values', () {
      const textTheme = FlutterDeckTextTheme();

      expect(textTheme.display.fontSize, 103);
      expect(textTheme.display.fontWeight, FontWeight.bold);
      expect(textTheme.header.fontSize, 57);
      expect(textTheme.header.fontWeight, FontWeight.w400);
      expect(textTheme.title.fontSize, 54);
      expect(textTheme.title.fontWeight, FontWeight.w400);
      expect(textTheme.subtitle.fontSize, 42);
      expect(textTheme.subtitle.fontWeight, FontWeight.w400);
      expect(textTheme.bodyLarge.fontSize, 28);
      expect(textTheme.bodyLarge.fontWeight, FontWeight.w400);
      expect(textTheme.bodyMedium.fontSize, 22);
      expect(textTheme.bodyMedium.fontWeight, FontWeight.w400);
      expect(textTheme.bodySmall.fontSize, 16);
      expect(textTheme.bodySmall.fontWeight, FontWeight.w400);
    });

    test('copyWith should return a new text theme with updated values', () {
      const textTheme = FlutterDeckTextTheme();
      const newStyle = TextStyle(fontSize: 100);
      final newTextTheme = textTheme.copyWith(display: newStyle);

      expect(newTextTheme.display, newStyle);
      expect(newTextTheme.header, textTheme.header);
    });

    test('merge should return a new text theme with merged values', () {
      const textTheme1 = FlutterDeckTextTheme();
      const textTheme2 = FlutterDeckTextTheme(display: TextStyle(color: Colors.red));
      final mergedTextTheme = textTheme1.merge(textTheme2);

      expect(mergedTextTheme.display.color, Colors.red);
      expect(mergedTextTheme.display.fontSize, 103); // Inherited from default 1
    });

    test('merge should return the same text theme if other is null', () {
      const textTheme = FlutterDeckTextTheme();
      final mergedTextTheme = textTheme.merge(null);

      expect(mergedTextTheme, textTheme);
    });

    test('apply should return a new text theme with applied color', () {
      const textTheme = FlutterDeckTextTheme();
      final newTextTheme = textTheme.apply(color: Colors.red);

      expect(newTextTheme.display.color, Colors.red);
      expect(newTextTheme.header.color, Colors.red);
      expect(newTextTheme.title.color, Colors.red);
      expect(newTextTheme.subtitle.color, Colors.red);
      expect(newTextTheme.bodyLarge.color, Colors.red);
      expect(newTextTheme.bodyMedium.color, Colors.red);
      expect(newTextTheme.bodySmall.color, Colors.red);
    });
  });
}
