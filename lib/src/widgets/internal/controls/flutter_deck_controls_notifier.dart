import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/actions.dart';
import 'package:flutter_deck/src/widgets/internal/drawer/drawer.dart';
import 'package:flutter_deck/src/widgets/internal/marker/marker.dart';

/// The [ChangeNotifier] used to control the slide deck and handle cursor
/// visibility.
///
/// This is used internally only.
class FlutterDeckControlsNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckControlsNotifier].
  FlutterDeckControlsNotifier({
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckRouter router,
  })  : _drawerNotifier = drawerNotifier,
        _markerNotifier = markerNotifier,
        _router = router;

  final FlutterDeckDrawerNotifier _drawerNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckRouter _router;

  var _cursorVisible = false;
  Timer? _cursorVisibleTimer;

  Set<Intent> _disabledIntents = {};

  /// Whether the cursor should be visible.
  bool get cursorVisible => _cursorVisible;

  /// Go to the next slide.
  void next() => _router.next();

  /// Go to the previous slide.
  void previous() => _router.previous();

  /// Toggle the navigation drawer.
  void toggleDrawer() => _drawerNotifier.toggle();

  ///
  void toggleMarker() {
    _markerNotifier.toggle();

    _disabledIntents = {
      if (_markerNotifier.enabled) ...{
        const GoNextIntent(),
        const GoPreviousIntent(),
        const ToggleDrawerIntent(),
      },
    };
  }

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

  ///
  bool intentDisabled(Intent intent) => _disabledIntents.contains(intent);
}
