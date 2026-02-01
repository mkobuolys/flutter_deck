---
title: Using plugins
navOrder: 1
---

# Using plugins

Plugins are a way to extend the functionality of `flutter_deck`. They can be used to wrap the `flutter_deck` with required providers or add a custom action to the controls that could be selected and execute custom logic.

## Adding plugins

To add a plugin to your slide deck, you can use the `plugins` property of the `FlutterDeckApp` constructor:

```dart
class MyDeck extends StatelessWidget {
  const MyDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      configuration: const FlutterDeckConfiguration(
        // ...
      ),
      plugins: [
        // Add your plugins here
      ],
      slides: [
        // ...
      ],
    );
  }
}
```
