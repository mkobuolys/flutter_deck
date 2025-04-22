---
title: Initial slide
navOrder: 6
---

By default, the first slide in the `slides` list is the initial slide. However, you can specify a different slide as the initial one by setting the `initial` property to `true` in the `FlutterDeckSlideConfiguration`.

**Important:** On Web, this property is only used when the path is not set. If the path is set, it will determine the initial slide.

```dart
class InitialSlide extends FlutterDeckSlideWidget {
  const InitialSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/initial',
            initial: true, // Sets this slide as the initial one
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: Text('This is the initial slide.'),
      ),
    );
  }
}
```
