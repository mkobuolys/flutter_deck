import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A widget that handles controls (actions and shortcuts) for the slide deck.
///
/// Key bindings are defined in global deck configuration. The following
/// shortcuts are supported:
///
/// * `nextKey` - Go to the next slide.
/// * `previousKey` - Go to the previous slide.
/// * `openDrawerKey` - Open the navigation drawer.
/// * `toggleMarkerKey` - Toggle the slide deck's marker.
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
  /// [notifier] is the [FlutterDeckControlsNotifier] that will be used to
  /// control the slide deck.
  const FlutterDeckControlsListener({
    required this.child,
    required this.notifier,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The notifier used to control the slide deck.
  final FlutterDeckControlsNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final controls = context.flutterDeck.globalConfiguration.controls;

    Widget widget = Focus(
      autofocus: true,
      child: ListenableBuilder(
        listenable: notifier,
        builder: (context, child) => MouseRegion(
          cursor: notifier.controlsVisible
              ? MouseCursor.defer
              : SystemMouseCursors.none,
          onHover: (_) => notifier.showControls(),
          child: child,
        ),
        child: child,
      ),
    );

    final shortcuts = controls.shortcuts;

    if (controls.presenterToolbarVisible || shortcuts.enabled) {
      widget = Actions(
        actions: <Type, Action<Intent>>{
          GoNextIntent: GoNextAction(notifier),
          GoPreviousIntent: GoPreviousAction(notifier),
          ToggleDrawerIntent: ToggleDrawerAction(notifier),
          ToggleMarkerIntent: ToggleMarkerAction(notifier),
        },
        child: widget,
      );

      if (shortcuts.enabled) {
        widget = Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(shortcuts.nextKey): const GoNextIntent(),
            LogicalKeySet(shortcuts.previousKey): const GoPreviousIntent(),
            LogicalKeySet(shortcuts.openDrawerKey): const ToggleDrawerIntent(),
            LogicalKeySet(shortcuts.toggleMarkerKey):
                const ToggleMarkerIntent(),
          },
          child: widget,
        );
      }
    }

    return widget;
  }
}
