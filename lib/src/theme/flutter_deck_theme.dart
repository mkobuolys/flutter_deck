import 'package:flutter/material.dart';

const _flutterBlue = Color(0xff0553B1);

/// Default theme for the slide deck.
class FlutterDeckTheme {
  /// Creates a light theme for the slide deck.
  const FlutterDeckTheme.light() : this._(brightness: Brightness.light);

  /// Creates a dark theme for the slide deck.
  const FlutterDeckTheme.dark() : this._(brightness: Brightness.dark);

  const FlutterDeckTheme._({
    required Brightness brightness,
  })  : _brightness = brightness,
        _seedColor = _flutterBlue;

  /// The primary color of the slide deck theme.
  ///
  /// This color is used as a seed color to generate the theme colors based on
  /// the Material 3 color system.
  final Color _seedColor;

  /// The brightness of the slide deck theme.
  ///
  /// This brightness is used to generate the theme colors based on the Material
  /// 3 color system.
  final Brightness _brightness;

  /// Returns the [ThemeData] for the slide deck.
  ///
  /// The [ThemeData] is generated based on the [_seedColor] and [_brightness].
  ThemeData get themeData => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: _brightness,
          seedColor: _seedColor,
        ),
        useMaterial3: true,
      );
}
