---
title: Presentation state
navOrder: 11
---

The slide deck state is managed by the `FlutterDeck` widget. This widget is responsible for managing the state of the slide deck, its configuration, navigation, and other details. By using the `FlutterDeck` extensions, you can access the slide deck state and its methods from anywhere in the app:

```dart
@override
Widget build(BuildContext context) {
  // Retrieve the FlutterDeck instance from the context.
  // Or by using the extension method: context.flutterDeck
  final flutterDeck = FlutterDeckProvider.of(context);

  // Retrieve the FlutterDeckRouter instance for this slide deck.
  final router = flutterDeck.router;
  // Retrieve the current slide configuration.
  final configuration = flutterDeck.configuration;
  // Retrieve the global slide deck configuration.
  final globalConfiguration = flutterDeck.globalConfiguration;
  // Retrieve the speaker info.
  final speakerInfo = flutterDeck.speakerInfo;

  // Go to the next slide.
  flutterDeck.next();
  // Go to the previous slide.
  flutterDeck.previous();

  // Retrieve the current slide number.
  final slideNumber = flutterDeck.slideNumber;
  // Go to the first slide.
  flutterDeck.goToSlide(1);

  // Retrieve the current step number.
  final stepNumber = flutterDeck.stepNumber;
  // Go to the first step.
  flutterDeck.goToStep(1);

  <...>
}
```
