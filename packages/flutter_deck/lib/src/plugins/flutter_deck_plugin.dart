import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/controls.dart' show FlutterDeckPluginMenuItemBuilder;
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

  /// Builds the controls for the plugin.
  ///
  /// This method is called when the controls are built. The returned widgets will
  /// be added to the controls.
  ///
  /// The [menuItemBuilder] can be used to build a menu item for the controls.
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) => [];

  /// Wraps the [child] with the plugin's widget.
  ///
  /// This method is called when the [FlutterDeckApp] is built. It can be used
  /// to inject providers or other widgets into the tree.
  Widget wrap(BuildContext context, Widget child) => child;
}
