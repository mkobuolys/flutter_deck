import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// A widget that handles controls (actions, gestures and shortcuts) for the
/// slide deck.
///
/// Key bindings are defined in global deck configuration. The following
/// shortcuts are supported:
///
/// * `nextSlide` - Go to the next slide.
/// * `previousSlide` - Go to the previous slide.
/// * `toggleMarker` - Toggle the slide deck's marker.
/// * `toggleNavigationDrawer` - Toggle the navigation drawer.
///
/// Also, custom shortcuts and actions can be defined by the user.
///
/// Cursor visibility is also handled by this widget. The cursor will be hidden
/// after 3 seconds of inactivity.
///
/// This widget is automatically added to the widget tree and should not be used
/// directly by the user.
class FlutterDeckControlsListener extends StatelessWidget {
  /// Creates a widget that provides controls for the slide deck.
  ///
  /// [child] is the widget that will be wrapped by this widget. It should be
  /// the root of the slide deck.
  ///
  /// [controlsNotifier] is the [FlutterDeckControlsNotifier] that will be used
  /// to control the slide deck.
  ///
  /// [markerNotifier] is the [FlutterDeckMarkerNotifier] that will be used to
  /// control the slide deck's marker.
  const FlutterDeckControlsListener({
    required this.child,
    required this.controlsNotifier,
    required this.markerNotifier,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The notifier used to control the slide deck.
  final FlutterDeckControlsNotifier controlsNotifier;

  /// The notifier used to control the slide deck's marker.
  final FlutterDeckMarkerNotifier markerNotifier;

  void _onHorizontalSwipe(DragEndDetails? details) {
    final velocity = details?.primaryVelocity;

    if (velocity == null) return;

    velocity > 0 ? controlsNotifier.previous() : controlsNotifier.next();
  }

  void _onMouseHover(PointerEvent event) {
    controlsNotifier.showControls();
  }

  void _onTap() {
    final controlsVisible = controlsNotifier.controlsVisible;

    controlsNotifier.showControls();

    if (!controlsVisible || markerNotifier.enabled) return;

    controlsNotifier.next();
  }

  @override
  Widget build(BuildContext context) {
    final controls = context.flutterDeck.globalConfiguration.controls;

    Widget widget = Focus(
      autofocus: true,
      child: ListenableBuilder(
        listenable: controlsNotifier,
        builder: (context, child) => MouseRegion(
          cursor: controlsNotifier.controlsVisible ? MouseCursor.defer : SystemMouseCursors.none,
          onHover: _onMouseHover,
          child: ListenableBuilder(
            listenable: markerNotifier,
            builder: (context, child) {
              if (!controls.gestures.enabled) return child!;

              if (markerNotifier.enabled) {
                return GestureDetector(onTap: _onTap, child: child);
              }

              return GestureDetector(onHorizontalDragEnd: _onHorizontalSwipe, onTap: _onTap, child: child);
            },
            child: child,
          ),
        ),
        child: child,
      ),
    );

    final shortcuts = controls.shortcuts;

    final allShortcuts = [
      ...shortcuts.nextSlide,
      ...shortcuts.previousSlide,
      ...shortcuts.toggleMarker,
      ...shortcuts.toggleNavigationDrawer,
      ...shortcuts.customShortcuts.map((e) => e.activator),
    ];

    final seen = <ShortcutActivator>{};

    for (final shortcut in allShortcuts) {
      assert(
        seen.add(shortcut),
        'Shortcuts must not clash with each other. '
        'Multiple actions are mapped to the "$shortcut" shortcut.',
      );
    }

    if (controls.presenterToolbarVisible || shortcuts.enabled) {
      widget = Actions(
        actions: <Type, Action<Intent>>{
          GoNextIntent: GoNextAction(controlsNotifier),
          GoPreviousIntent: GoPreviousAction(controlsNotifier),
          ToggleDrawerIntent: ToggleDrawerAction(controlsNotifier),
          ToggleMarkerIntent: ToggleMarkerAction(controlsNotifier),
          for (final shortcut in shortcuts.customShortcuts) shortcut.intentType: shortcut.action,
        },
        child: widget,
      );

      if (shortcuts.enabled) {
        widget = Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            for (final activator in shortcuts.nextSlide) activator: const GoNextIntent(),
            for (final activator in shortcuts.previousSlide) activator: const GoPreviousIntent(),
            for (final activator in shortcuts.toggleMarker) activator: const ToggleMarkerIntent(),
            for (final activator in shortcuts.toggleNavigationDrawer) activator: const ToggleDrawerIntent(),
            for (final shortcut in shortcuts.customShortcuts) shortcut.activator: shortcut.intent,
          },
          child: widget,
        );
      }
    }

    return widget;
  }
}
