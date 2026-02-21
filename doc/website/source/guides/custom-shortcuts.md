---
title: Custom shortcuts
navOrder: 10
---

# Custom Shortcuts

Flutter Deck allows you to define custom shortcuts to control your presentation using the keyboard. By default, it includes shortcuts for navigating between slides, toggling the marker, and opening the navigation drawer. You can add your own shortcuts to trigger specific actions.

## Defining Custom Shortcuts

To add custom shortcuts, you need to configure the `FlutterDeckShortcutsConfiguration` when setting up your `FlutterDeckApp`. This configuration requires a list of custom shortcuts that extend the abstract `FlutterDeckShortcut` class. This class binds a `ShortcutActivator` (like a key press), an `Intent`, and an `Action` together.

### Example: Skip to the Next Topic

Imagine you have a long presentation and want a quick way to skip ahead 5 slides. You can accomplish this by creating a custom intent and a corresponding action. Then, implement the `FlutterDeckShortcut` interface to bundle them.

```dart
class SkipTopicIntent extends Intent {
  const SkipTopicIntent();
}

class SkipTopicAction extends ContextAction<SkipTopicIntent> {
  @override
  Object? invoke(SkipTopicIntent intent, BuildContext context) {
    // Jump ahead 5 slides
    for (var i = 0; i < 5; i++) {
        context.flutterDeck.next();
    }
    return null;
  }
}

class SkipTopicShortcut extends FlutterDeckShortcut<SkipTopicIntent> {
  const SkipTopicShortcut();

  @override
  ShortcutActivator get activator =>
      const SingleActivator(LogicalKeyboardKey.keyS, control: true);

  @override
  SkipTopicIntent get intent => const SkipTopicIntent();

  @override
  Action<SkipTopicIntent> get action => SkipTopicAction();
}

// In your FlutterDeckApp configuration:
FlutterDeckApp(
  configuration: const FlutterDeckConfiguration(
    controls: FlutterDeckControlsConfiguration(
      shortcuts: FlutterDeckShortcutsConfiguration(
        customShortcuts: [
          SkipTopicShortcut(),
        ],
      ),
    ),
  ),
  // ... other app setup
)
```

In this example, pressing `Ctrl + S` triggers the `SkipTopicIntent`. The `SkipTopicAction`, extending `ContextAction`, gains access to the `BuildContext` allowing it to call `context.flutterDeck.next()` repeatedly. If the shortcut doesn't require context, you can simply extend `Action`.

## Avoiding Shortcut Clashes

Flutter Deck automatically checks if your custom shortcuts clash with the default ones (like the arrow keys for navigation or 'M' for the marker). If a clash is detected, it will throw an `AssertionError` during development, explicitly stating which shortcut key is causing the problem.

For instance, trying to assign a custom action to the right arrow key will trigger the following error:

```text
Shortcuts must not clash with each other. Multiple actions are mapped to the "LogicalKeySet(LogicalKeyboardKey#00115(keyId: "0x100000015", keyLabel: "Arrow Right", debugName: "Arrow Right"))" shortcut.
```

> [!NOTE]
> Custom shortcuts cannot use the same key combinations as the default shortcuts (`nextSlide`, `previousSlide`, `toggleMarker`, `toggleNavigationDrawer`). Doing so will result in an assertion error. Defaults can be removed or disabled via their respective fields if you need to reuse their key combinations.
