import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/transitions/flutter_deck_transition_builders.dart';

/// A transtion class used to define the transition between slides.
class FlutterDeckTransition {
  /// Creates a [FlutterDeckTransition] that uses a custom transition.
  ///
  /// The [_transitionBuilder] is required and is used to build the transition.
  const FlutterDeckTransition.custom({required FlutterDeckTransitionBuilder transitionBuilder})
    : _transitionBuilder = transitionBuilder;

  /// Creates a [FlutterDeckTransition] that uses a [FadeTransition].
  const FlutterDeckTransition.fade() : _transitionBuilder = const FlutterDeckFadeTransitionBuilder();

  /// Creates a [FlutterDeckTransition] that uses a [ScaleTransition].
  const FlutterDeckTransition.scale() : _transitionBuilder = const FlutterDeckScaleTransitionBuilder();

  /// Creates a [FlutterDeckTransition] that uses a [SlideTransition].
  const FlutterDeckTransition.slide() : _transitionBuilder = const FlutterDeckSlideTransitionBuilder();

  /// Creates a [FlutterDeckTransition] that uses a [RotationTransition].
  const FlutterDeckTransition.rotation() : _transitionBuilder = const FlutterDeckRotationTransitionBuilder();

  /// Creates a [FlutterDeckTransition] that does not use any transition.
  const FlutterDeckTransition.none() : _transitionBuilder = const FlutterDeckNoTransitionBuilder();

  /// The builder used to build the transition.
  final FlutterDeckTransitionBuilder _transitionBuilder;

  /// Builds the transition between slides.
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return _transitionBuilder.build(context, animation, secondaryAnimation, child);
  }
}
