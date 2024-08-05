---
title: Presenter View
navOrder: 6
---
The presenter view allows you to control your presentation from a separate screen or (even) device. It displays the current slide, speaker notes, and a timer.

![Presenter view demo](https://github.com/mkobuolys/flutter_deck/blob/main/images/presenter-view.gif?raw=true)

To enable the presenter view, you to use one of the [flutter_deck_client](https://pub.dev/packages/flutter_deck_client) implementations. The client synchronizes the state of the slide deck with the presenter view and vice versa.

### (Web only) flutter_deck_web_client

If you plan to run your slide deck on the web, it is recommended to use the [flutter_deck_web_client](https://pub.dev/packages/flutter_deck_web_client) package. This client does not require any server-side code to run and works out of the box on any Web browser.

All you need to do is to add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_deck_web_client: any
```

And pass the `FlutterDeckWebClient` to the `FlutterDeckApp` widget:

```dart
FlutterDeckApp(
  client: const FlutterDeckWebClient(), // Use the Web client
  configuration: const FlutterDeckConfiguration(...),
  slides: [
    <...>
  ],
);
```

### flutter_deck_ws_client

This client is a WebSocket-based implementation that requires a server-side code to run. The server-side code is responsible for synchronizing the state of the slide deck with the presenter view and vice versa. However, this implementation can be used on any platform. E.g., you can control your slide deck from your mobile device.

To use the client, add the [flutter_deck_ws_client](https://pub.dev/packages/flutter_deck_ws_client) package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_deck_ws_client: any
```

Extract your `FlutterDeckApp` widget to a separate file:

```dart
/// flutter_deck_example.dart
class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({
    required this.isPresenterView,
    super.key,
  });

  final bool isPresenterView;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      client: FlutterDeckWsClient(uri: Uri.parse('ws://localhost:8080')), // Use the WebSocket client
      isPresenterView: isPresenterView,
      <...>
    );
  }
}
```

Then, create two entry points for your slide deck: one for the presenter view and one for the slide deck itself:

```dart
/// main.dart
void main() {
  runApp(const FlutterDeckExample(isPresenterView: false));
}
```

```dart
/// main_presenter.dart
void main() {
  runApp(const FlutterDeckExample(isPresenterView: true));
}
```

Launch the WebSocket server, e.g., [flutter_deck_ws_server](https://github.com/mkobuolys/flutter_deck/tree/main/packages/flutter_deck_ws_server):

```sh
# Install the dart_frog cli from source
dart pub global activate dart_frog_cli

# Start the dev server
dart_frog dev
```

Launch your presentation as two separate Flutter applications:

```sh
# Run the slide deck
flutter run -t main.dart

# Run the presenter view
flutter run -t main_presenter.dart
```
