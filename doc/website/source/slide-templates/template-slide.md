---
title: Template Slide
navOrder: 6
---

To create a custom template slide, use the `FlutterDeckSlide.template` constructor. It is responsible for placing the header, footer, and content of the slide in the correct places. Also, it is responsible for displaying the background of the slide.

```dart
class TemplateSlide extends FlutterDeckSlideWidget {
  const TemplateSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/template-slide',
            title: 'Template slide',
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.template(
      backgroundBuilder: (context) => FlutterDeckBackground.solid(
        Theme.of(context).colorScheme.background,
      ),
      contentBuilder: (context) => const ColoredBox(
        color: Colors.red,
        child: Text('Content goes here...'),
      ),
      footerBuilder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: const Text('Footer goes here...'),
      ),
      headerBuilder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.primary,
        child: const Text('Header goes here...'),
      ),
    );
  }
}
```

![FlutterDeckSlideBase](https://github.com/mkobuolys/flutter_deck/blob/main/images/templates/custom.png?raw=true)
