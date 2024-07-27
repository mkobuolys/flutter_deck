---
title: Title Slide
navOrder: 1
---
To create a title slide, use the `FlutterDeckSlide.title` constructor. It is responsible for rendering the default header and footer of the slide deck, and placing the title and subtitle in the correct places. Also, if the `FlutterDeckSpeakerInfo` is set, it will render the speaker info below the title and subtitle.

```dart
class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title-slide',
            title: 'Title slide',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Here goes the title of the slide',
      subtitle: 'Here goes the subtitle of the slide (optional)',
    );
  }
}
```

![Title slide example](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/title.png?raw=true)