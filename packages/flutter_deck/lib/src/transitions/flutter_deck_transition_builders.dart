import 'package:flutter/material.dart';

/// A builder for a transition between slides.
abstract class FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckTransitionBuilder].
  const FlutterDeckTransitionBuilder();

  /// Builds the transition between slides.
  ///
  /// The method has the same signature as the [PageTransitionsBuilder] used by
  /// the [MaterialPageRoute].
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);
}

/// A builder for a [FadeTransition].
class FlutterDeckFadeTransitionBuilder extends FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckFadeTransitionBuilder].
  const FlutterDeckFadeTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// A builder for a [ScaleTransition].
class FlutterDeckScaleTransitionBuilder extends FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckScaleTransitionBuilder].
  const FlutterDeckScaleTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(scale: animation, child: child);
  }
}

/// A builder for a [SlideTransition].
class FlutterDeckSlideTransitionBuilder extends FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckSlideTransitionBuilder].
  const FlutterDeckSlideTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeIn)),
      ),
      child: child,
    );
  }
}

/// A builder for a [RotationTransition].
class FlutterDeckRotationTransitionBuilder extends FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckRotationTransitionBuilder].
  const FlutterDeckRotationTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return RotationTransition(turns: animation, child: child);
  }
}

/// A builder that does not perform any transition.
///
/// This is the default transition used for the slide deck.
class FlutterDeckNoTransitionBuilder extends FlutterDeckTransitionBuilder {
  /// Default constructor for [FlutterDeckNoTransitionBuilder].
  const FlutterDeckNoTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
