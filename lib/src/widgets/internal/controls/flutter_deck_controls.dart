import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/internal/controls/flutter_deck_controls_notifier.dart';

/// A widget that provides controls for the slide deck.
///
/// Key bindings are defined in global deck configuration. The following
/// shortcuts are supported:
///
/// * `nextKey` - Go to the next slide.
/// * `previousKey` - Go to the previous slide.
/// * `openDrawerKey` - Open the navigation drawer.
///
/// Cursor visibility is also handled by this widget. The cursor will be hidden
/// after 3 seconds of inactivity.
///
/// This widget is automatically added to the widget tree and should not be used
/// directly by the user.
class FlutterDeckControls extends StatefulWidget {
  /// Creates a widget that provides controls for the slide deck.
  ///
  /// [child] is the widget that will be wrapped by this widget. It should be
  /// the root of the slide deck.
  const FlutterDeckControls({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<FlutterDeckControls> createState() => _FlutterDeckControlsState();
}

class _FlutterDeckControlsState extends State<FlutterDeckControls> {
  FlutterDeckControlsNotifier? _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_notifier != null) return;

    _notifier = FlutterDeckControlsNotifier(context.flutterDeck);
  }

  @override
  void dispose() {
    _notifier?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controls = context.flutterDeck.globalConfiguration.controls;

    Widget child = Focus(
      autofocus: true,
      child: widget.child,
    );

    if (controls.enabled) {
      child = Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(controls.nextKey): const _GoNextIntent(),
          LogicalKeySet(controls.previousKey): const _GoPreviousIntent(),
          LogicalKeySet(controls.openDrawerKey): const _OpenDrawerIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _GoNextIntent: CallbackAction(
              onInvoke: (_) => _notifier?.next(),
            ),
            _GoPreviousIntent: CallbackAction(
              onInvoke: (_) => _notifier?.previous(),
            ),
            _OpenDrawerIntent: CallbackAction(
              onInvoke: (_) => _notifier?.toggleDrawer(),
            ),
          },
          child: child,
        ),
      );
    }

    if (_notifier != null) {
      child = ListenableBuilder(
        listenable: _notifier!,
        builder: (context, child) => MouseRegion(
          cursor: _notifier!.cursorVisible
              ? MouseCursor.defer
              : SystemMouseCursors.none,
          onHover: (_) => _notifier!.showCursor(),
          child: child,
        ),
        child: child,
      );
    }

    return child;
  }
}

class _GoNextIntent extends Intent {
  const _GoNextIntent();
}

class _GoPreviousIntent extends Intent {
  const _GoPreviousIntent();
}

class _OpenDrawerIntent extends Intent {
  const _OpenDrawerIntent();
}
