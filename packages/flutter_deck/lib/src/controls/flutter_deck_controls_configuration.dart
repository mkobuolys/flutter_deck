import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

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
  });

  /// Creates a configuration for the slide deck controls where they are
  /// disabled.
  const FlutterDeckControlsConfiguration.disabled()
    : this(
        presenterToolbarVisible: false,
        gestures: const FlutterDeckGesturesConfiguration.disabled(),
        shortcuts: const FlutterDeckShortcutsConfiguration.disabled(),
      );

  /// Whether the presenter toolbar is visible or not.
  final bool presenterToolbarVisible;

  /// The configuration for the slide deck controls gestures.
  final FlutterDeckGesturesConfiguration gestures;

  /// The configuration for the slide deck keyboard shortcuts.
  final FlutterDeckShortcutsConfiguration shortcuts;
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
    this.nextSlide = const {SingleActivator(LogicalKeyboardKey.arrowRight)},
    this.previousSlide = const {SingleActivator(LogicalKeyboardKey.arrowLeft)},
    this.toggleMarker = const {SingleActivator(LogicalKeyboardKey.keyM)},
    this.toggleNavigationDrawer = const {SingleActivator(LogicalKeyboardKey.period)},
    this.customShortcuts = const {},
    this.customActions = const {},
  });

  /// Creates a configuration for the slide deck keyboard shortcuts where they
  /// are disabled.
  const FlutterDeckShortcutsConfiguration.disabled() : this(enabled: false);

  /// Whether keyboard shortcuts are enabled or not.
  final bool enabled;

  /// The key combinations to use for going to the next slide.
  final Set<ShortcutActivator> nextSlide;

  /// The key combinations to use for going to the previous slide.
  final Set<ShortcutActivator> previousSlide;

  /// The key combinations to use for toggling the marker.
  final Set<ShortcutActivator> toggleMarker;

  /// The key combinations to use for toggling the navigation drawer.
  final Set<ShortcutActivator> toggleNavigationDrawer;

  /// Custom shortcuts for the slide deck.
  ///
  /// This can be used to add custom shortcuts to the slide deck. The
  /// [ShortcutActivator] is the key combination that will trigger the
  /// shortcut, and the [Intent] is the intent that will be invoked when
  /// the shortcut is triggered.
  ///
  /// To handle the intent, provide a corresponding [Action] in the
  /// [FlutterDeckShortcutsConfiguration.customActions] map.
  final Map<ShortcutActivator, Intent> customShortcuts;

  /// Custom actions for the slide deck.
  ///
  /// This can be used to add custom actions to the slide deck. The
  /// [Type] is the type of the [Intent] that the action will handle, and
  /// the [Action] is the action that will be invoked when the intent is
  /// triggered.
  ///
  /// To access the [FlutterDeck] via these action intents, you can use a
  /// [ContextAction] instead of a regular [Action]. For example:
  ///
  /// ```dart
  /// class MyCustomAction extends ContextAction<MyCustomIntent> {
  ///   @override
  ///   Object? invoke(MyCustomIntent intent, BuildContext context) {
  ///     final flutterDeck = context.flutterDeck;
  ///     // Do something with the flutter_deck instance...
  ///     return null;
  ///   }
  /// }
  /// ```
  final Map<Type, Action<Intent>> customActions;
}
