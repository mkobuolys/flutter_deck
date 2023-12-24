import 'package:flutter/services.dart';

/// The configuration for the slide deck controls.
class FlutterDeckControlsConfiguration {
  /// Creates a configuration for the slide deck controls. By default, the
  /// presenter toolbar is visible and the default keyboard controls are
  /// enabled.
  ///
  /// The default keyboard shortcuts are:
  /// - Next slide: \[ArrowRight\]
  /// - Previous slide: \[ArrowLeft\]
  /// - Toggle marker: \[KeyM\]
  /// - Toggle navigation drawer: \[Period\]
  const FlutterDeckControlsConfiguration({
    this.presenterToolbarVisible = true,
    this.shortcuts = const FlutterDeckShortcutsConfiguration(),
  });

  /// Whether the presenter toolbar is visible or not.
  final bool presenterToolbarVisible;

  /// The configuration for the slide deck keyboard shortcuts.
  final FlutterDeckShortcutsConfiguration shortcuts;
}

/// The configuration for the slide deck keyboard shortcuts.
class FlutterDeckShortcutsConfiguration {
  /// Creates a configuration for the slide deck keyboard shortcuts. By default,
  /// shortcuts are enabled.
  ///
  /// The default keyboard shortcuts are:
  /// - Next slide: \[ArrowRight\]
  /// - Previous slide: \[ArrowLeft\]
  /// - Toggle marker: \[KeyM\]
  /// - Toggle navigation drawer: \[Period\]
  const FlutterDeckShortcutsConfiguration({
    this.enabled = true,
    List<LogicalKeyboardKey> nextSlide = const [
      LogicalKeyboardKey.arrowRight,
    ],
    List<LogicalKeyboardKey> previousSlide = const [
      LogicalKeyboardKey.arrowLeft,
    ],
    List<LogicalKeyboardKey> toggleMarker = const [
      LogicalKeyboardKey.keyM,
    ],
    List<LogicalKeyboardKey> toggleNavigationDrawer = const [
      LogicalKeyboardKey.period,
    ],
  })  : _nextSlide = nextSlide,
        _previousSlide = previousSlide,
        _toggleMarker = toggleMarker,
        _toggleNavigationDrawer = toggleNavigationDrawer;

  /// Whether keyboard shortcuts are enabled or not.
  final bool enabled;

  final List<LogicalKeyboardKey> _nextSlide;

  /// The key combination to use for going to the next slide.
  Set<LogicalKeyboardKey> get nextSlide => {..._nextSlide};

  final List<LogicalKeyboardKey> _previousSlide;

  /// The key combination to use for going to the previous slide.
  Set<LogicalKeyboardKey> get previousSlide => {..._previousSlide};

  final List<LogicalKeyboardKey> _toggleMarker;

  /// The key combination to use for toggling the marker.
  Set<LogicalKeyboardKey> get toggleMarker => {..._toggleMarker};

  final List<LogicalKeyboardKey> _toggleNavigationDrawer;

  /// The key combination to use for toggling the navigation drawer.
  Set<LogicalKeyboardKey> get toggleNavigationDrawer =>
      {..._toggleNavigationDrawer};
}
