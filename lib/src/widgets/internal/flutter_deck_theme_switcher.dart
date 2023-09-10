import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// [SwitchListTile] to toggle the theme of the slide deck.
///
/// This widget is for internal use only.
class FlutterDeckThemeSwitcher extends StatelessWidget {
  /// Creates a [FlutterDeckThemeSwitcher] to toggle slide deck theme.
  const FlutterDeckThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.flutterDeck.themeNotifier;

    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return SwitchListTile(
          title: const Text('Dark mode'),
          value: context.darkModeEnabled(themeMode),
          onChanged: (useDarkMode) => themeNotifier.update(
            useDarkMode ? ThemeMode.dark : ThemeMode.light,
          ),
        );
      },
    );
  }
}
