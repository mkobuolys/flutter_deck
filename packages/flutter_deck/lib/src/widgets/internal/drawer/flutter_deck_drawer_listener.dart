import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// A widget that listens to the [FlutterDeckDrawerNotifier] and calls the
/// [onDrawerToggle] callback.
class FlutterDeckDrawerListener extends StatefulWidget {
  /// Creates a [FlutterDeckDrawerListener].
  ///
  /// The [onDrawerToggle] callback and [child] arguments must not be null.
  const FlutterDeckDrawerListener({required this.onDrawerToggle, required this.child, super.key});

  /// The callback that is called when the drawer should be toggled.
  final VoidCallback onDrawerToggle;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<FlutterDeckDrawerListener> createState() => _FlutterDeckDrawerListenerState();
}

class _FlutterDeckDrawerListenerState extends State<FlutterDeckDrawerListener> {
  FlutterDeckDrawerNotifier? _notifier;

  @override
  void dispose() {
    _notifier?.removeListener(_onDrawerToggle);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_notifier != null) return;

    _notifier = context.flutterDeck.drawerNotifier..addListener(_onDrawerToggle);
  }

  void _onDrawerToggle() {
    if (_notifier == null) return;

    widget.onDrawerToggle();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
