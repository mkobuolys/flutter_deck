import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A linear progress indicator that shows the current progress of the
/// presentation.
///
/// The progress is calculated by the number of total steps in the presentation
/// and the current step.
class FlutterDeckProgressIndicator extends StatefulWidget {
  /// Creates a progress indicator with a solid color.
  const FlutterDeckProgressIndicator.solid(Color color) : this._(color: color);

  /// Creates a progress indicator with a gradient.
  const FlutterDeckProgressIndicator.gradient(Gradient gradient)
      : this._(gradient: gradient);

  /// A private constructor for the [FlutterDeckProgressIndicator] widget.
  ///
  /// This constructor is private because it should not be used directly.
  /// Instead, use one of the public constructors.
  const FlutterDeckProgressIndicator._({
    this.color,
    this.gradient,
  });

  /// The progress indicator color.
  ///
  /// This value is only provided via the [FlutterDeckProgressIndicator.solid]
  /// constructor.
  final Color? color;

  /// The progress indicator gradient.
  ///
  /// This value is only provided
  /// via the [FlutterDeckProgressIndicator.gradient] constructor.
  final Gradient? gradient;

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
    if (widget.gradient != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final indicatorWidth = maxWidth * _progress;
          return Container(
            height: 8,
            width: maxWidth,
            color: Colors.grey,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: indicatorWidth,
                decoration: BoxDecoration(gradient: widget.gradient),
              ),
            ),
          );
        },
      );
    } else {
      return LinearProgressIndicator(
        backgroundColor: Colors.grey,
        color: widget.color,
        value: _progress,
      );
    }
  }
}
