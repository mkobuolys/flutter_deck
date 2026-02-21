import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A shortcut for the slide deck.
///
/// This configuration is used to map a key combination to an [Intent] and an
/// [Action].
class FlutterDeckShortcut {
  /// Creates a shortcut for the slide deck.
  const FlutterDeckShortcut({required this.activator, required this.intent, required this.action});

  /// The key combination that will trigger the shortcut.
  final ShortcutActivator activator;

  /// The intent that will be invoked when the shortcut is triggered.
  final Intent intent;

  /// The action that will be invoked when the intent is triggered.
  ///
  /// To access [FlutterDeck] via this action, you can use a [ContextAction]
  /// instead of a regular [Action].
  final Action<Intent> action;
}
