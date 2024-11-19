A Web client for the [flutter_deck](https://pub.dev/packages/flutter_deck) package.

## About

This package implements the [FlutterDeckClient](https://pub.dev/packages/flutter_deck_client) interface for the Web platform.

It uses the [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) API to store the state of the presentation and keep it in sync with the presenter view.

The main benefit of this client is that it doesn't require any server-side code to run and works out of the box on any Web browser. However, the main drawback is that it works only on Web platform.

## Usage

To use this package, add `flutter_deck_web_client` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_deck_web_client: any
```

Then, use the `FlutterDeckWebClient` class when creating your `FlutterDeckApp` presentation.

```dart
FlutterDeckApp(
  client: FlutterDeckWebClient(), // Use the Web client
  configuration: const FlutterDeckConfiguration(...),
  slides: [
    <...>
  ],
);
```
