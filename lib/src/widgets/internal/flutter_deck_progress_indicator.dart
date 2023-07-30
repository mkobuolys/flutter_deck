import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A linear progress indicator that shows the current progress of the
/// presentation.
///
/// The progress is calculated by the number of total steps in the presentation
/// and the current step.
class FlutterDeckProgressIndicator extends StatefulWidget {
  /// Creates a progress indicator for the slide deck.
  const FlutterDeckProgressIndicator({super.key});

  @override
  State<FlutterDeckProgressIndicator> createState() =>
      _FlutterDeckProgressIndicatorState();
}

class _FlutterDeckProgressIndicatorState
    extends State<FlutterDeckProgressIndicator> {
  FlutterDeckRouter? _router;
  var _progress = 0.0;

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

    _onRouteChange();
  }

  void _onRouteChange() {
    if (_router == null) return;

    final totalSteps = _router!.slides.fold(0, _sumSteps);
    final currentStep = _router!.slides
        .sublist(0, context.flutterDeck.slideNumber - 1)
        .fold(0, _sumSteps);

    setState(() {
      _progress = (currentStep + context.flutterDeck.stepNumber) / totalSteps;
    });
  }

  int _sumSteps(int total, FlutterDeckRouterSlide slide) {
    return total + slide.configuration.steps;
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: _progress);
  }
}
