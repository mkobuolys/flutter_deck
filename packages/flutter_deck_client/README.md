A common client interface and models for the [flutter_deck](https://pub.dev/packages/flutter_deck) package.

## Usage

To implement a new client for [flutter_deck](https://pub.dev/packages/flutter_deck), implement [FlutterDeckClient](https://github.com/mkobuolys/flutter_deck/tree/main/packages/flutter_deck_client/lib/src/flutter_deck_client.dart) interface with your own logic:

```dart
class MyFlutterDeckClient implements FlutterDeckClient {
  const MyFlutterDeckClient();

  @override
  Stream<FlutterDeckState> get flutterDeckStateStream { <...> }

  @override
  void init([FlutterDeckState? state]) { <...> }

  @override
  void dispose() { <...> }

  @override
  void openPresenterView() { <...> }

  @override
  void updateState(FlutterDeckState state) { <...> }
}
```

## Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface) over breaking changes for this package.
