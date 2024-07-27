---
title: Custom Slide
navOrder: 8
---
To create a custom slide (without any predefined template), use the `FlutterDeckSlide.custom` constructor and pass a custom `builder` to it.

```dart
class CustomSlide extends FlutterDeckSlideWidget {
  const CustomSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/custom-slide',
            title: 'Custom slide',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const Text('Here goes your custom slide content...');
      },
    );
  }
}
```
