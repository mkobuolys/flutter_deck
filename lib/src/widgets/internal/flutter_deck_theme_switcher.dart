import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// [SwitchListTile] to toggle the theme of the slide deck.
///
/// This widget is for internal use only.
class FlutterDeckThemeSwitcher extends StatelessWidget {
  /// Creates a [FlutterDeckThemeSwitcher] to toggle slide deck theme.
  const FlutterDeckThemeSwitcher({super.key});

  bool _darkModeEnabled(
    Brightness brightness,
    ThemeMode themeMode,
  ) =>
      switch (themeMode) {
        ThemeMode.system => brightness == Brightness.dark,
        ThemeMode.light => false,
        ThemeMode.dark => true,
      };

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.flutterDeck.themeNotifier;

    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        final darkModeEnabled = _darkModeEnabled(
          MediaQuery.of(context).platformBrightness,
          themeMode,
        );

        return SwitchListTile(
          title: const Text('Dark mode'),
          value: darkModeEnabled,
          onChanged: (useDarkMode) => themeNotifier.update(
            useDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
    );
  }
}
