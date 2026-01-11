import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// The configuration for the slide deck controls.
class FlutterDeckControlsConfiguration {
  /// Creates a configuration for the slide deck controls. By default, the
  /// presenter toolbar is visible, the default keyboard controls are
  /// enabled, and gestures are enabled on mobile platforms only.
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
    this.gestures = const FlutterDeckGesturesConfiguration.mobileOnly(),
    this.shortcuts = const FlutterDeckShortcutsConfiguration(),
    this.menuItems = const [],
  });

  /// Creates a configuration for the slide deck controls where they are
  /// disabled.
  const FlutterDeckControlsConfiguration.disabled()
    : this(
        presenterToolbarVisible: false,
        gestures: const FlutterDeckGesturesConfiguration.disabled(),
        shortcuts: const FlutterDeckShortcutsConfiguration.disabled(),
        menuItems: const [],
      );

  /// Whether the presenter toolbar is visible or not.
  final bool presenterToolbarVisible;

  /// The configuration for the slide deck controls gestures.
  final FlutterDeckGesturesConfiguration gestures;

  /// The configuration for the slide deck keyboard shortcuts.
  final FlutterDeckShortcutsConfiguration shortcuts;

  /// Custom menu items to show in the controls menu.
  final List<Widget> menuItems;
}

/// The configuration for the slide deck control gestures.
///
/// The gesture controls are only available on [supportedPlatforms]. By default,
/// gestures are enabled on all platforms.
class FlutterDeckGesturesConfiguration {
  /// Creates a configuration for the slide deck control gestures.
  const FlutterDeckGesturesConfiguration({this.supportedPlatforms = const {...TargetPlatform.values}});

  /// Creates a configuration for the slide deck control gestures where they are
  /// disabled.
  const FlutterDeckGesturesConfiguration.disabled() : this(supportedPlatforms: const {});

  /// Creates a configuration for the slide deck control gestures where they are
  /// enabled on mobile platforms only.
  const FlutterDeckGesturesConfiguration.mobileOnly()
    : this(supportedPlatforms: const {TargetPlatform.android, TargetPlatform.iOS});

  /// The platforms where gestures are enabled.
  final Set<TargetPlatform> supportedPlatforms;

  /// Whether gestures are enabled on the current platform or not.
  bool get enabled => supportedPlatforms.contains(defaultTargetPlatform);
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
    this.toggleNavigationDrawer = const SingleActivator(LogicalKeyboardKey.period),
  });

  /// Creates a configuration for the slide deck keyboard shortcuts where they
  /// are disabled.
  const FlutterDeckShortcutsConfiguration.disabled() : this(enabled: false);

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
