import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/drawer/drawer.dart';
import 'package:flutter_deck/src/widgets/internal/marker/marker.dart';

const _defaultControlsVisibleDuration = Duration(seconds: 3);

/// The [ChangeNotifier] used to control the slide deck and handle cursor and
/// deck controls visibility.
class FlutterDeckControlsNotifier with ChangeNotifier implements FlutterDeckFullscreenManager {
  /// Creates a [FlutterDeckControlsNotifier].
  FlutterDeckControlsNotifier({
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckFullscreenManager fullscreenManager,
    required FlutterDeckRouter router,
  }) : _drawerNotifier = drawerNotifier,
       _markerNotifier = markerNotifier,
       _fullscreenManager = fullscreenManager,
       _router = router;

  final FlutterDeckDrawerNotifier _drawerNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckFullscreenManager _fullscreenManager;
  final FlutterDeckRouter _router;

  var _controlsVisible = false;
  var _controlsVisibleDuration = _defaultControlsVisibleDuration;
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

  /// Go to the slide with the given [slideNumber].
  void goToSlide(int slideNumber) {
    _router.goToSlide(slideNumber);
    notifyListeners();
  }

  /// Go to the slide step with the given [stepNumber].
  void goToStep(int stepNumber) {
    _router.goToStep(stepNumber);
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
      if (_markerNotifier.enabled) ...{const GoNextIntent(), const GoPreviousIntent(), const ToggleDrawerIntent()},
    };

    showControls();
    notifyListeners();
  }

  @override
  bool canFullscreen() => _fullscreenManager.canFullscreen();

  @override
  Future<bool> isInFullscreen() => _fullscreenManager.isInFullscreen();

  @override
  Future<void> enterFullscreen() => _fullscreenManager.enterFullscreen();

  @override
  Future<void> leaveFullscreen() => _fullscreenManager.leaveFullscreen();

  /// Show the cursor and controls.
  ///
  /// The cursor and deck controls will be hidden after 3 seconds of inactivity.
  void showControls() {
    _setControlsVisible(true);

    _controlsVisibleTimer = Timer(_controlsVisibleDuration, () => _setControlsVisible(false));
  }

  void _setControlsVisible(bool visible) {
    _controlsVisibleTimer?.cancel();

    if (_controlsVisible == visible) return;

    _controlsVisible = visible;
    notifyListeners();
  }

  /// Toggle the cursor and controls visibility duration.
  ///
  /// The value toggles between 3 seconds and infinite (no auto-hide).
  void toggleControlsVisibleDuration() {
    _controlsVisibleDuration = _controlsVisibleDuration > _defaultControlsVisibleDuration
        ? _defaultControlsVisibleDuration
        : const Duration(days: 1); // Infinite enough for this use case...
  }

  /// Whether the given [intent] is disabled.
  bool intentDisabled(Intent intent) => _disabledIntents.contains(intent);
}
