import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_app.dart';

/// A plugin for the [FlutterDeck].
///
/// Plugins can be used to add custom functionality to the [FlutterDeck].
///
/// See also:
/// * [FlutterDeckApp.plugins], which is used to register plugins.
abstract class FlutterDeckPlugin {
  /// Initializes the plugin.
  ///
  /// This method is called once when the [FlutterDeck] is created.
  void init(FlutterDeck flutterDeck);

  /// Disposes the plugin.
  ///
  /// This method is called once when the [FlutterDeck] is disposed.
  void dispose();
}
