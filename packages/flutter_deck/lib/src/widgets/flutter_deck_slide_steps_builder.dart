import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A signature for a function that builds a widget for a slide step. The
/// function is passed the [BuildContext] and the [stepNumber] of the slide.
typedef FlutterDeckSlideStepsWidgetBuilder = Widget Function(BuildContext context, int stepNumber);

/// A widget that builds a widget for a slide step. The widget is rebuilt when
/// the slide step changes.
///
/// This widget is useful for building a widget that changes based on the slide
/// step. For example, a widget that displays a list of items and highlights the
/// current item based on the slide step.
class FlutterDeckSlideStepsBuilder extends StatefulWidget {
  /// Creates a widget that builds a widget for a slide step.
  ///
  /// The [builder] argument must not be null.
  const FlutterDeckSlideStepsBuilder({required this.builder, super.key});

  /// The widget builder for the slide step.
  final FlutterDeckSlideStepsWidgetBuilder builder;

  @override
  State<FlutterDeckSlideStepsBuilder> createState() => _FlutterDeckSlideStepsBuilderState();
}

class _FlutterDeckSlideStepsBuilderState extends State<FlutterDeckSlideStepsBuilder> {
  FlutterDeckRouter? _router;
  int? _stepNumber;
  int? _slideNumber;

  @override
  void dispose() {
    _router?.removeListener(_onRouteChange);

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_router != null) return;

    final flutterDeck = context.flutterDeck;

    _slideNumber = flutterDeck.slideNumber;
    _router = flutterDeck.router..addListener(_onRouteChange);

    // Needed for the first render, e.g. when the user navigates to a slide
    // directly via URL or deep link.
    _onRouteChange();
  }

  void _onRouteChange() {
    final flutterDeck = context.flutterDeck;

    if (_slideNumber != flutterDeck.slideNumber) return;

    setState(() => _stepNumber = flutterDeck.stepNumber);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _stepNumber ?? 1);
  }
}
