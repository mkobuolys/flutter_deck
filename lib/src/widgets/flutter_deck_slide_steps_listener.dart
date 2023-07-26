import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A signature for a function that is called when the slide step changes. The
/// function is passed the [BuildContext] and the [stepNumber] of the slide.
typedef FlutterDeckSlideStepsWidgetListener = void Function(
  BuildContext context,
  int stepNumber,
);

/// A widget that listens for changes to the slide step. The listener is called
/// when the slide step changes.
///
/// This widget is useful for listening to changes to the slide step. For
/// example, when the slide step changes, the listener can be used to trigger
/// an animation or any other side effect.
class FlutterDeckSlideStepsListener extends StatefulWidget {
  /// Creates a widget that listens for changes to the slide step.
  ///
  /// The [listener] and [child] arguments must not be null.
  const FlutterDeckSlideStepsListener({
    required this.listener,
    required this.child,
    super.key,
  });

  /// The listener for the slide step.
  final FlutterDeckSlideStepsWidgetListener listener;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<FlutterDeckSlideStepsListener> createState() =>
      _FlutterDeckSlideStepsListenerState();
}

class _FlutterDeckSlideStepsListenerState
    extends State<FlutterDeckSlideStepsListener> {
  FlutterDeckRouter? _router;

  @override
  void dispose() {
    _router?.removeListener(_onRouteChange);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_router != null) return;

    _router = context.flutterDeck.router..addListener(_onRouteChange);
  }

  void _onRouteChange() {
    widget.listener(context, context.flutterDeck.stepNumber);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
