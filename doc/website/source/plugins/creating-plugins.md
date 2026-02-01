---
title: Creating plugins
navOrder: 2
---

# Creating plugins

If you want to add custom functionality to `flutter_deck`, you can create your own plugins. A plugin can be used to wrap the `FlutterDeckApp` with required providers or add a custom action to the controls that could be selected and execute custom logic.

Plugins are designed to be reusable components that can be shared across multiple slide decks. If you create a plugin that provides general-purpose functionality, consider publishing it to [pub.dev](https://pub.dev) so others in the community can benefit from it.

## FlutterDeckPlugin

To create a plugin, you need to extend the `FlutterDeckPlugin` class. This class has four methods: `init`, `dispose`, `buildControls`, and `wrap`.

### `init`

The `init` method is called once when the `FlutterDeck` is created. It can be used to initialize the plugin.

The `flutterDeck` parameter provides access to the state of the slide deck, such as the current slide number, the configuration, and the router. You can use it to listen to state changes or to navigate programmatically.

```dart
@override
void init(FlutterDeck flutterDeck) {
  // Initialize the plugin
}
```

### `dispose`

The `dispose` method is called once when the `FlutterDeck` is disposed. It can be used to dispose of any resources used by the plugin.

```dart
@override
void dispose() {
  // Dispose the plugin
}
```

### `buildControls`

The `buildControls` method is called when the controls are built. It can be used to add custom controls to the presenter toolbar. The method returns a list of widgets that will be added to the controls.

The method also provides a `FlutterDeckPluginMenuItemBuilder` that can be used to help you build menu items for the controls.

```dart
@override
List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) {
  return [
    menuItemBuilder(
      context,
      label: 'My Plugin',
      onPressed: () {
        // Execute custom logic
      },
    ),
  ];
}
```

### `wrap`

The `wrap` method is called when the `FlutterDeckApp` is built. It can be used to inject providers or other widgets into the tree.

```dart
@override
Widget wrap(BuildContext context, Widget child) {
  return SomeProvider(
    child: child,
  );
}
```

## Example

Here is an example of a simple plugin that prints a message to the console when initialized and adds a custom action to the controls. When the action is clicked, a `SnackBar` is shown with a message.

```dart
class MyPlugin extends FlutterDeckPlugin {
  const MyPlugin();

  @override
  void init(FlutterDeck flutterDeck) {
    print('MyPlugin initialized');
  }

  @override
  void dispose() {
    print('MyPlugin disposed');
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) {
    return [
      menuItemBuilder(
        context,
        label: 'Show message',
        icon: const Icon(Icons.message),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hello from MyPlugin!'),
            ),
          );
        },
      ),
    ];
  }
}
```

For a more complex example, see the [auto-play](/plugins/auto-play) plugin.
