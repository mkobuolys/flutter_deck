import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/drawer/drawer.dart';
import 'package:flutter_deck/src/widgets/internal/marker/marker.dart';

/// The [ChangeNotifier] used to control the slide deck and handle cursor and
/// deck controls visibility.
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

  var _controlsVisible = false;
  Timer? _controlsVisibleTimer;

  Set<Intent> _disabledIntents = {};

  /// Whether the cursor and deck controls are visible.
  bool get controlsVisible => _controlsVisible;

  /// Go to the next slide.
  void next() {
    _router.next();
    notifyListeners();
  }

  /// Go to the previous slide.
  void previous() {
    _router.previous();
    notifyListeners();
  }

  /// Toggle the navigation drawer.
  void toggleDrawer() {
    _drawerNotifier.toggle();
    notifyListeners();
  }

  /// Toggle the slide deck's marker.
  ///
  /// When the marker is enabled, the following intents are disabled:
  /// * [GoNextIntent]
  /// * [GoPreviousIntent]
  /// * [ToggleDrawerIntent]
  void toggleMarker() {
    _markerNotifier.toggle();

    _disabledIntents = {
      if (_markerNotifier.enabled) ...{
        const GoNextIntent(),
        const GoPreviousIntent(),
        const ToggleDrawerIntent(),
      },
    };

    showControls();
    notifyListeners();
  }

  /// Show the cursor and controls.
  ///
  /// The cursor and deck controls will be hidden after 3 seconds of inactivity.
  void showControls() {
    _setControlsVisible(true);

    _controlsVisibleTimer = Timer(
      const Duration(seconds: 3),
      () => _setControlsVisible(false),
    );
  }

  void _setControlsVisible(bool visible) {
    _controlsVisibleTimer?.cancel();

    if (_controlsVisible == visible) return;

    _controlsVisible = visible;
    notifyListeners();
  }

  /// Whether the given [intent] is disabled.
  bool intentDisabled(Intent intent) => _disabledIntents.contains(intent);
}
