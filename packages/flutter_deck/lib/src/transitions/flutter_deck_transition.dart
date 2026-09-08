import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/transitions/flutter_deck_transition_builders.dart';

/// A transtion class used to define the transition between slides.
class FlutterDeckTransition {
  /// Creates a [FlutterDeckTransition] that uses a custom transition.
  ///
  /// The [_transitionBuilder] is required and is used to build the transition.
  const FlutterDeckTransition.custom({required FlutterDeckTransitionBuilder transitionBuilder})
    : this._(transitionBuilder: transitionBuilder);

  /// Creates a [FlutterDeckTransition] that uses a [FadeTransition].
  const FlutterDeckTransition.fade() : this._(transitionBuilder: const FlutterDeckFadeTransitionBuilder());

  /// Creates a [FlutterDeckTransition] that uses a [ScaleTransition].
  const FlutterDeckTransition.scale() : this._(transitionBuilder: const FlutterDeckScaleTransitionBuilder());

  /// Creates a [FlutterDeckTransition] that uses a [SlideTransition].
  const FlutterDeckTransition.slide() : this._(transitionBuilder: const FlutterDeckSlideTransitionBuilder());

  /// Creates a [FlutterDeckTransition] that uses a [RotationTransition].
  const FlutterDeckTransition.rotation() : this._(transitionBuilder: const FlutterDeckRotationTransitionBuilder());

  /// Creates a [FlutterDeckTransition] that does not use any transition.
  const FlutterDeckTransition.none() : this._(transitionBuilder: const FlutterDeckNoTransitionBuilder());

  /// This constructor is private because it should not be used directly.
  /// Instead, use one of the public constructors.
  const FlutterDeckTransition._({
    required FlutterDeckTransitionBuilder transitionBuilder,
    this.duration = const Duration(milliseconds: 300),
  }) : _transitionBuilder = transitionBuilder;

  /// The builder used to build the transition.
  final FlutterDeckTransitionBuilder _transitionBuilder;

  /// A duration to customize the duration of the page transition.
  ///
  /// Defaults to 300ms.
  final Duration duration;

  /// Builds the transition between slides.
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return _transitionBuilder.build(context, animation, secondaryAnimation, child);
  }

  /// Creates a copy of this transition but with duration set to the new value.
  FlutterDeckTransition copyWith({required Duration duration}) {
    return FlutterDeckTransition._(transitionBuilder: _transitionBuilder, duration: duration);
  }
}
