import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  ///
  /// See also:
  /// - [SingleActivator] for more information on how to define a key
  /// combination.
  /// - [LogicalKeyboardKey] for a list of all available keys.
  const FlutterDeckControlsConfiguration({
    this.presenterToolbarVisible = true,
    this.shortcuts = const FlutterDeckShortcutsConfiguration(),
  });

  /// Creates a configuration for the slide deck controls where they are
  /// disabled.
  const FlutterDeckControlsConfiguration.disabled()
      : presenterToolbarVisible = false,
        shortcuts = const FlutterDeckShortcutsConfiguration(enabled: false);

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
  ///
  /// See also:
  /// - [SingleActivator] for more information on how to define a key
  /// combination.
  /// - [LogicalKeyboardKey] for a list of all available keys.
  const FlutterDeckShortcutsConfiguration({
    this.enabled = true,
    this.nextSlide = const SingleActivator(LogicalKeyboardKey.arrowRight),
    this.previousSlide = const SingleActivator(LogicalKeyboardKey.arrowLeft),
    this.toggleMarker = const SingleActivator(LogicalKeyboardKey.keyM),
    this.toggleNavigationDrawer =
        const SingleActivator(LogicalKeyboardKey.period),
  });

  /// Whether keyboard shortcuts are enabled or not.
  final bool enabled;

  /// The key combination to use for going to the next slide.
  final SingleActivator nextSlide;

  /// The key combination to use for going to the previous slide.
  final SingleActivator previousSlide;

  /// The key combination to use for toggling the marker.
  final SingleActivator toggleMarker;

  /// The key combination to use for toggling the navigation drawer.
  final SingleActivator toggleNavigationDrawer;
}
