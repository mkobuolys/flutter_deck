import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// The [ChangeNotifier] used to control the slide deck and handle cursor
/// visibility.
///
/// This is used internally only.
class FlutterDeckControlsNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckControlsNotifier].
  FlutterDeckControlsNotifier(this._flutterDeck);

  final FlutterDeck _flutterDeck;

  Timer? _cursorVisibleTimer;

  /// Whether the cursor should be visible.
  bool get cursorVisible => _cursorVisible;
  var _cursorVisible = false;

  /// Go to the next slide.
  void next() => _flutterDeck.next();

  /// Go to the previous slide.
  void previous() => _flutterDeck.previous();

  /// Toggle the navigation drawer.
  void toggleDrawer() => _flutterDeck.drawerNotifier.toggle();

  ///
  void toggleMarker() => _flutterDeck.markerNotifier.toggle();

  /// Show the cursor.
  ///
  /// The cursor will be hidden after 3 seconds.
  void showCursor() {
    _setCursorVisible(true);

    _cursorVisibleTimer = Timer(
      const Duration(seconds: 3),
      () => _setCursorVisible(false),
    );
  }

  void _setCursorVisible(bool visible) {
    _cursorVisibleTimer?.cancel();

    if (_cursorVisible == visible) return;

    _cursorVisible = visible;
    notifyListeners();
  }
}
