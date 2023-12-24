import 'package:flutter/services.dart';

/// The configuration for the slide deck controls.
class FlutterDeckControlsConfiguration {
  /// Creates a configuration for the slide deck controls. By default, the
  /// presenter toolbar is visible and the default keyboard controls are
  /// enabled.
  ///
  /// The default keyboard controls are:
  /// - Next slide: ArrowRight
  /// - Previous slide: ArrowLeft
  /// - Open drawer: Period
  /// - Toggle marker: KeyM
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
  /// - Next slide: ArrowRight
  /// - Previous slide: ArrowLeft
  /// - Open drawer: Period
  /// - Toggle marker: KeyM
  const FlutterDeckShortcutsConfiguration({
    this.enabled = true,
    this.nextKey = LogicalKeyboardKey.arrowRight,
    this.previousKey = LogicalKeyboardKey.arrowLeft,
    this.openDrawerKey = LogicalKeyboardKey.period,
    this.toggleMarkerKey = LogicalKeyboardKey.keyM,
  });

  /// Whether keyboard shortcuts are enabled or not.
  final bool enabled;

  /// The key to use for going to the next slide.
  final LogicalKeyboardKey nextKey;

  /// The key to use for going to the previous slide.
  final LogicalKeyboardKey previousKey;

  /// The key to use for opening the navigation drawer.
  final LogicalKeyboardKey openDrawerKey;

  /// The key to use for toggling the marker.
  final LogicalKeyboardKey toggleMarkerKey;
}
