import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A shortcut for the slide deck.
///
/// This configuration is used to map a key combination to an [Intent] and an
/// [Action].
abstract class FlutterDeckShortcut<T extends Intent> {
  /// Creates a shortcut for the slide deck.
  const FlutterDeckShortcut();

  /// The key combination that will trigger the shortcut.
  ShortcutActivator get activator;

  /// The intent that will be invoked when the shortcut is triggered.
  T get intent;

  /// The action that will be invoked when the intent is triggered.
  ///
  /// To access [FlutterDeck] via this action, you can use a [ContextAction]
  /// instead of a regular [Action].
  Action<T> get action;
}
