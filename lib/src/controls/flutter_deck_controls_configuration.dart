import 'package:flutter/services.dart';

/// The configuration for the slide deck controls.
class FlutterDeckControlsConfiguration {
  /// Creates a configuration for the slide deck controls. By default, controls
  /// and shortcuts are enabled.
  ///
  /// The default keyboard controls are:
  /// - Next slide: ArrowRight
  /// - Previous slide: ArrowLeft
  /// - Open drawer: Period
  /// - Toggle marker: KeyM
  const FlutterDeckControlsConfiguration({
    this.enabled = true,
    this.shortcutsEnabled = true,
    this.nextKey = LogicalKeyboardKey.arrowRight,
    this.previousKey = LogicalKeyboardKey.arrowLeft,
    this.openDrawerKey = LogicalKeyboardKey.period,
    this.toggleMarkerKey = LogicalKeyboardKey.keyM,
  });

  /// Whether controls are enabled or not.
  final bool enabled;

  /// Whether keyboard shortcuts are enabled or not.
  final bool shortcutsEnabled;

  /// The key to use for going to the next slide.
  final LogicalKeyboardKey nextKey;

  /// The key to use for going to the previous slide.
  final LogicalKeyboardKey previousKey;

  /// The key to use for opening the navigation drawer.
  final LogicalKeyboardKey openDrawerKey;

  /// The key to use for toggling the marker.
  final LogicalKeyboardKey toggleMarkerKey;
}
