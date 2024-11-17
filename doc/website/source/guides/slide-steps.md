---
title: Multi-Step Slides
navOrder: 4
---

Steps is a feature that allows you to navigate through a slide, well, step by step. You can access the current step from any widget. This way, you can reveal or hide content, run animations, etc.

To enable steps for a slide, you need to set the `steps` property for the slide configuration:

```dart
class StepsDemoSlide extends FlutterDeckSlideWidget {
  const StepsDemoSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/steps-demo',
            title: 'Steps demo',
            steps: 2,
          ),
        );

  <...>
}
```

To trigger a rebuild of the widget when the step changes, you can use the `FlutterDeckSlideStepsBuilder` widget:

```dart
@override
Widget build(BuildContext context) {
  return FlutterDeckSlideStepsBuilder(
    builder: (context, stepNumber) => stepNumber == 1
        ? const Text('This is the first step.')
        : const Text('This is the second step.'),
  );
}
```

Or you can use the `FlutterDeckSlideStepsListener` to trigger side effects when the step changes:

```dart
@override
Widget build(BuildContext context) {
  return FlutterDeckSlideStepsListener(
    listener: (context, stepNumber) {
      print('Current step: $stepNumber');
    },
    child: const Text('Steps demo slide'),
  );
}
```

![Steps demo](https://github.com/mkobuolys/flutter_deck/blob/main/images/steps.gif?raw=true)
