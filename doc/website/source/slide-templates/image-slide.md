---
title: Image slide
navOrder: 3
---

To create an image slide, use the `FlutterDeckSlide.image` constructor. It is responsible for rendering the default header and footer of the slide deck, and rendering the image using the provided `imageBuilder`.

```dart
class ImageSlide extends FlutterDeckSlideWidget {
  const ImageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/image-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Image slide template',
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset('assets/image.png'),
      label: 'Here goes the label of the image (optional)',
    );
  }
}
```

![Image slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/image.png?raw=true)
