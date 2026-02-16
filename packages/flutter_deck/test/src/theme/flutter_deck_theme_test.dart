import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/flutter_deck_text_theme.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckThemeData', () {
    test('should have correct default values', () {
      final theme = FlutterDeckThemeData();

      expect(theme.materialTheme.brightness, Brightness.light);
      expect(theme.textTheme, isNotNull);
    });

    test('light factory should create a light theme', () {
      final theme = FlutterDeckThemeData.light();

      expect(theme.materialTheme.brightness, Brightness.light);
    });

    test('dark factory should create a dark theme', () {
      final theme = FlutterDeckThemeData.dark();

      expect(theme.materialTheme.brightness, Brightness.dark);
    });

    test('fromTheme factory should create a theme from ThemeData', () {
      final materialTheme = ThemeData.dark();
      final theme = FlutterDeckThemeData.fromTheme(materialTheme);

      expect(theme.materialTheme, materialTheme);
      expect(theme.materialTheme.brightness, Brightness.dark);
    });

    test('fromThemeAndText factory should create a theme from ThemeData and TextTheme', () {
      final materialTheme = ThemeData.light();
      const textTheme = FlutterDeckTextTheme();
      final theme = FlutterDeckThemeData.fromThemeAndText(materialTheme, textTheme);

      expect(theme.materialTheme, materialTheme);
      expect(theme.textTheme, textTheme);
    });

    test('copyWith should return a new theme with updated values', () {
      final theme = FlutterDeckThemeData.light();
      final newTextTheme = const FlutterDeckTextTheme().apply(color: Colors.red);
      final newTheme = theme.copyWith(textTheme: newTextTheme);

      expect(newTheme.textTheme, newTextTheme);
      expect(newTheme.materialTheme, theme.materialTheme);
    });

    test('merge should return a new theme with merged values', () {
      final theme1 = FlutterDeckThemeData.light();
      final theme2 = FlutterDeckThemeData.dark();
      final mergedTheme = theme1.merge(theme2);

      expect(mergedTheme.materialTheme.brightness, Brightness.dark);
    });

    test('merge should return the same theme if other is null', () {
      final theme = FlutterDeckThemeData.light();
      final mergedTheme = theme.merge(null);

      expect(mergedTheme, theme);
    });
  });

  group('FlutterDeckTheme', () {
    testWidgets('should provide theme data to descendants', (tester) async {
      final themeData = FlutterDeckThemeData.light();
      late FlutterDeckThemeData result;

      await tester.pumpWidget(
        FlutterDeckTheme(
          data: themeData,
          child: Builder(
            builder: (context) {
              result = FlutterDeckTheme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, themeData);
    });

    testWidgets('should throw error if no theme found in context', (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(() => FlutterDeckTheme.of(context), throwsAssertionError);
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('updateShouldNotify should return true if data is different', (tester) async {
      final themeData1 = FlutterDeckThemeData.light();
      final themeData2 = FlutterDeckThemeData.dark();

      await tester.pumpWidget(FlutterDeckTheme(data: themeData1, child: const SizedBox()));

      final widget1 = tester.widget<FlutterDeckTheme>(find.byType(FlutterDeckTheme));

      await tester.pumpWidget(FlutterDeckTheme(data: themeData2, child: const SizedBox()));

      final widget2 = tester.widget<FlutterDeckTheme>(find.byType(FlutterDeckTheme));

      expect(widget2.updateShouldNotify(widget1), true);
    });
  });

  group('FlutterDeckThemeX', () {
    testWidgets('flutterDeckTheme extension should return theme data', (tester) async {
      final themeData = FlutterDeckThemeData.light();
      late FlutterDeckThemeData result;

      await tester.pumpWidget(
        FlutterDeckTheme(
          data: themeData,
          child: Builder(
            builder: (context) {
              result = context.flutterDeckTheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, themeData);
    });

    testWidgets('darkModeEnabled should return correct value based on ThemeMode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.darkModeEnabled(ThemeMode.light), false);
              expect(context.darkModeEnabled(ThemeMode.dark), true);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('darkModeEnabled should return correct value based on platform brightness', (test) async {
      // Only way to test platform brightness usually involves setting MediaQuery, but let's see defaults.
      // Default is light.
      await test.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(context.darkModeEnabled(ThemeMode.system), false);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
