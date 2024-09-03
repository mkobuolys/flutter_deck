// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';

/// The [ValueNotifier] used to toggle the theme of the slide deck.
///
/// This is used internally only.
class FlutterDeckThemeNotifier extends ValueNotifier<ThemeMode> {
  /// Creates a [FlutterDeckThemeNotifier] with the given [value].
  FlutterDeckThemeNotifier(super._value);

  /// Changes the value of the [FlutterDeckThemeNotifier] to the given
  /// [themeMode].
  void update(ThemeMode themeMode) => value = themeMode;
}
