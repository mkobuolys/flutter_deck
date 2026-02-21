---
title: Custom shortcuts
navOrder: 10
---

# Custom shortcuts

It is possible to define custom shortcuts to control your presentation using the keyboard. By default, it includes shortcuts for navigating between slides, toggling the marker, and opening the navigation drawer. You can add your own shortcuts to trigger specific actions.

## Defining custom shortcuts

To add custom shortcuts, you need to configure the `FlutterDeckShortcutsConfiguration` when setting up your `FlutterDeckApp`. This configuration requires a list of custom shortcuts that extend the abstract `FlutterDeckShortcut` class. This class binds a `ShortcutActivator` (like a key press), an `Intent`, and an `Action` together.

### Example: Skip to the next slide

In flutter_deck, slides can have multiple steps. This example shows how to add a custom shortcut to skip to the next slide, ignoring the steps.

```dart
class SkipSlideIntent extends Intent {
  const SkipSlideIntent();
}

class SkipSlideAction extends ContextAction<SkipSlideIntent> {
  @override
  Object? invoke(SkipSlideIntent intent, [BuildContext? context]) {
    if (context == null) return null;

    final currentSlide = context.flutterDeck.router.currentSlideIndex + 1;

    context.flutterDeck.router.goToSlide(currentSlide + 1);

    return null;
  }
}

class SkipSlideShortcut extends FlutterDeckShortcut<SkipSlideIntent> {
  const SkipSlideShortcut();

  @override
  ShortcutActivator get activator => const SingleActivator(LogicalKeyboardKey.arrowRight, alt: true);

  @override
  SkipSlideIntent get intent => const SkipSlideIntent();

  @override
  Action<SkipSlideIntent> get action => SkipSlideAction();
}
```

Then, add the shortcut to your presentation:

```dart
FlutterDeckApp(
  configuration: const FlutterDeckConfiguration(
    controls: FlutterDeckControlsConfiguration(
      shortcuts: FlutterDeckShortcutsConfiguration(
        customShortcuts: [
          SkipSlideShortcut(),
        ],
      ),
    ),
  ),
)
```

In this example, pressing `Ctrl + S` triggers the `SkipSlideIntent`. The `SkipSlideAction`, extending `ContextAction`, gains access to the `BuildContext` allowing it to call `context.flutterDeck.router.goToSlide()` to skip to the next slide. If the shortcut doesn't require context, you can simply extend `Action`.

## Avoiding shortcut clashes

The flutter_deck framework automatically checks if your custom shortcuts clash with any of the default shortcuts or any other custom shortcuts. If a clash is detected, it will throw an `AssertionError` during development, explicitly stating which shortcut key is causing the problem.
