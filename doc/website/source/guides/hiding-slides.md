---
title: Hiding Slides
navOrder: 3
---

By default, all slides are visible and available in the slide deck. However, you can hide a slide by setting the `hidden` property to `true` for the slide configuration:

```dart
class HiddenSlide extends FlutterDeckSlideWidget {
  const HiddenSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/hidden',
            hidden: true, // Sets the slide to be hidden
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(
        child: Text("This slide is hidden. Oh, but you can't see it..."),
      ),
    );
  }
}
```
