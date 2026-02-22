import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A shortcut for the slide deck.
///
/// This configuration is used to map a key combination to an [Intent] and an
/// [Action].
abstract class FlutterDeckShortcut<T extends Intent> {
  /// Creates a shortcut for the slide deck.
  const FlutterDeckShortcut();

  /// The action that will be invoked when the intent is triggered.
  ///
  /// To access [FlutterDeck] via this action, you can use a [ContextAction]
  /// instead of a regular [Action].
  Action<T> get action;

  /// The key combinations that will trigger the shortcut.
  Set<ShortcutActivator> get activators;

  /// The intent that will be invoked when the shortcut is triggered.
  T get intent;

  /// The type of the intent that will be invoked when the shortcut is
  /// triggered.
  ///
  /// This is used to map the intent type to the action in the controls
  /// listener. Do not override this, it relies on the generic type [T].
  Type get intentType => T;
}
