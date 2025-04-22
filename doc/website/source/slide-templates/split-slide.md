---
title: Split slide
navOrder: 5
---

To create a split slide, use the `FlutterDeckSlide.split` constructor. It is responsible for rendering the default header and footer of the slide deck, and use the `leftBuilder` and `rightBuilder` to create the content of the left and right columns. Make sure to use text styles from `Theme` or `FlutterDeckTheme` to apply the correct text styling for specific slide sections.

```dart
class SplitSlide extends FlutterDeckSlideWidget {
  const SplitSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/split-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Split slide template',
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return Text(
          'Here goes the LEFT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
      rightBuilder: (context) {
        return Text(
          'Here goes the RIGHT section content of the slide',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }
}
```

![Split slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/split.png?raw=true)
