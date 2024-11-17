---
title: Blank Slide
navOrder: 7
---

To create a title slide, use the `FlutterDeckSlide.blank` constructor. It is responsible for rendering the default header and footer of the slide deck, and rendering the content of the slide using the provided `builder`.

```dart
class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Blank slide template',
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Text('Here goes the content of the slide'),
    );
  }
}
```

![Blank slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/blank.png?raw=true)
