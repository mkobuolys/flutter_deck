import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// A widget that provides keyboard shortcuts for navigating the slide deck.
///
/// Key bindings are defined in global deck configuration. The following
/// shortcuts are supported:
///
/// * `nextKey` - Go to the next slide.
/// * `previousKey` - Go to the previous slide.
/// * `openDrawerKey` - Open the navigation drawer.
///
/// This widget is automatically added to the widget tree and should not be used
/// directly by the user.
class FlutterDeckShortcuts extends StatelessWidget {
  /// Creates a widget that provides keyboard shortcuts for navigating the slide
  /// deck.
  ///
  /// [child] is the widget that will be wrapped by this widget. It should be
  /// the root of the slide deck.
  const FlutterDeckShortcuts({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controls = flutterDeck.globalConfiguration.controls;

    return controls.enabled
        ? Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(controls.nextKey): const _GoNextIntent(),
              LogicalKeySet(controls.previousKey): const _GoPreviousIntent(),
              LogicalKeySet(controls.openDrawerKey): const _OpenDrawerIntent(),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                _GoNextIntent: CallbackAction(
                  onInvoke: (_) => flutterDeck.next(),
                ),
                _GoPreviousIntent: CallbackAction(
                  onInvoke: (_) => flutterDeck.previous(),
                ),
                _OpenDrawerIntent: CallbackAction(
                  onInvoke: (_) => flutterDeck.drawerNotifier.toggle(),
                ),
              },
              child: Focus(
                autofocus: true,
                child: child,
              ),
            ),
          )
        : child;
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
