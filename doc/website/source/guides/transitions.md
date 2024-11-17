---
title: Transitions
navOrder: 7
---

This package comes with a few predefined transitions that can be used for your slides:

- `FlutterDeckTransition.none` (default)
- `FlutterDeckTransition.fade`
- `FlutterDeckTransition.scale`
- `FlutterDeckTransition.slide`
- `FlutterDeckTransition.rotation`
- `FlutterDeckTransition.custom`

You can specify a transition for the whole slide deck:

```dart
FlutterDeckApp(
  configuration: const FlutterDeckConfiguration(
    transition: FlutterDeckTransition.fade(),
  ),
  <...>
);
```

Or you can specify a transition for a specific slide:

```dart
class TransitionsSlide extends FlutterDeckSlideWidget {
  const TransitionsSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/transitions',
            title: 'Transitions',
            transition: FlutterDeckTransition.rotation(), // Specify the transition for the slide
          ),
        );

  <...>
}
```

`FlutterDeckTransition.custom` accepts a `FlutterDeckTransitionBuilder` that can be extended to create a custom transition:

```dart
class VerticalTransitionBuilder extends FlutterDeckTransitionBuilder {
  const VerticalTransitionBuilder();

  @override
  Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeIn)),
      ),
      child: child,
    );
  }
}

class CustomTransitionSlide extends FlutterDeckSlideWidget {
  const CustomTransitionSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/custom-transition',
            title: 'Custom transition',
            transition: FlutterDeckTransition.custom(
              transitionBuilder: VerticalTransitionBuilder(),
            ),
          ),
        );

  <...>
}
```
