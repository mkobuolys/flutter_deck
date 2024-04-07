# flutter_deck_ws_client

A WebSocket client for the [flutter_deck](https://pub.dev/packages/flutter_deck) package.

## About

This package implements the [FlutterDeckClient](https://pub.dev/packages/flutter_deck_client) interface using [web_socket_client](https://pub.dev/packages/web_socket_client).

It uses WebSockets to keep the state of the presentation in sync with the presenter view.

The main benefit of this client is that it works on any platform that supports WebSockets. However, the main drawback is that it requires a WebSocket server to run.

## Usage

To use this package, add `flutter_deck_ws_client` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_deck_ws_client: any
```

Then, use the `FlutterDeckWsClient` class when creating your `FlutterDeckApp` presentation.

```dart
FlutterDeckApp(
  client: FlutterDeckWsClient(uri: Uri.parse('ws://localhost:8080')), // Use the WebSocket client
  configuration: const FlutterDeckConfiguration(...),
  slides: [
    <...>
  ],
);
```
