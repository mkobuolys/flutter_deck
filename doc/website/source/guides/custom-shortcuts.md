---
title: Custom shortcuts
navOrder: 10
---

The `flutter_deck` package allows you to define custom keyboard shortcuts and actions for your presentation. This is useful if you want to add new functionality or override default behavior.

## Adding Custom Shortcuts

To add custom shortcuts, you need to provide a `FlutterDeckShortcutsConfiguration` to your `FlutterDeckControlsConfiguration`. This configuration accepts `customShortcuts` and `customActions` maps.

### Example: Skip Slide Shortcut

As an example, let's implement a shortcut to skip the current slide and jump to the next one, without going through its remaining steps.

First, define a custom `Intent` for the action:

```dart
import 'package:flutter/widgets.dart';

class SkipSlideIntent extends Intent {
  const SkipSlideIntent();
}
```

Next, define the corresponding `Action`. The framework allows you to access the `FlutterDeck` instance inside an action by extending `ContextAction`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SkipSlideAction extends ContextAction<SkipSlideIntent> {
  const SkipSlideAction();

  @override
  Object? invoke(SkipSlideIntent intent, [BuildContext? context]) {
    if (context == null) return null;

    final flutterDeck = context.flutterDeck;
    final router = flutterDeck.router;
    final currentIndex = router.currentSlideIndex;

    // Skip to the next slide
    if (currentIndex < router.slides.length - 1) {
      flutterDeck.goToSlide(currentIndex + 2);
    }

    return null;
  }
}
```

Finally, map the intent and action in your `FlutterDeckApp` configuration. For example, to map the `SkipSlideIntent` to `Meta + Right Arrow`:

```dart
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MyPresentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      configuration: FlutterDeckConfiguration(
        controls: FlutterDeckControlsConfiguration(
          shortcuts: FlutterDeckShortcutsConfiguration(
            customShortcuts: const {
              SingleActivator(LogicalKeyboardKey.arrowRight, meta: true): SkipSlideIntent(),
            },
            customActions: {
              SkipSlideIntent: const SkipSlideAction(),
            },
          ),
        ),
      ),
      slides: [
        // ... your slides
      ],
    );
  }
}
```

> [!NOTE]
> Custom shortcuts cannot use the same key combinations as the default shortcuts (`nextSlide`, `previousSlide`, `toggleMarker`, `toggleNavigationDrawer`). Doing so will result in an assertion error. Defaults can be removed or disabled via their respective fields if you need to reuse their key combinations.
