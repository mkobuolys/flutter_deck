import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A widget that handles controls (actions and shortcuts) for the slide deck.
///
/// Key bindings are defined in global deck configuration. The following
/// shortcuts are supported:
///
/// * `nextSlide` - Go to the next slide.
/// * `previousSlide` - Go to the previous slide.
/// * `toggleMarker` - Toggle the slide deck's marker.
/// * `toggleNavigationDrawer` - Toggle the navigation drawer.
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
  const FlutterDeckControlsListener({
    required this.child,
    required this.controlsNotifier,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The notifier used to control the slide deck.
  final FlutterDeckControlsNotifier controlsNotifier;

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

    if (!controlsVisible) return;

    controlsNotifier.next();
  }

  @override
  Widget build(BuildContext context) {
    final controls = context.flutterDeck.globalConfiguration.controls;
    final gesturesEnabled = controls.gestures.enabled;

    Widget? gestureDetector(Widget? child) {
      if (!gesturesEnabled) return child;

      return GestureDetector(
        onHorizontalDragEnd: _onHorizontalSwipe,
        onTap: _onTap,
        child: child,
      );
    }

    Widget widget = Focus(
      autofocus: true,
      child: ListenableBuilder(
        listenable: controlsNotifier,
        builder: (context, child) => MouseRegion(
          cursor: controlsNotifier.controlsVisible
              ? MouseCursor.defer
              : SystemMouseCursors.none,
          onHover: _onMouseHover,
          child: gestureDetector(child),
        ),
        child: child,
      ),
    );

    final shortcuts = controls.shortcuts;

    if (controls.presenterToolbarVisible || shortcuts.enabled) {
      widget = Actions(
        actions: <Type, Action<Intent>>{
          GoNextIntent: GoNextAction(controlsNotifier),
          GoPreviousIntent: GoPreviousAction(controlsNotifier),
          ToggleDrawerIntent: ToggleDrawerAction(controlsNotifier),
          ToggleMarkerIntent: ToggleMarkerAction(controlsNotifier),
        },
        child: widget,
      );

      if (shortcuts.enabled) {
        widget = Shortcuts(
          shortcuts: <SingleActivator, Intent>{
            shortcuts.nextSlide: const GoNextIntent(),
            shortcuts.previousSlide: const GoPreviousIntent(),
            shortcuts.toggleMarker: const ToggleMarkerIntent(),
            shortcuts.toggleNavigationDrawer: const ToggleDrawerIntent(),
          },
          child: widget,
        );
      }
    }

    return widget;
  }
}
