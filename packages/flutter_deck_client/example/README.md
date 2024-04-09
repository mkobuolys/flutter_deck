# Web client example

Source: [flutter_deck_web_client](https://pub.dev/packages/flutter_deck_web_client)

```dart
class FlutterDeckWebClient implements FlutterDeckClient {
  FlutterDeckWebClient() : _controller = StreamController<FlutterDeckState>();

  final StreamController<FlutterDeckState> _controller;

  @override
  Stream<FlutterDeckState> get flutterDeckStateStream => _controller.stream;

  @override
  void init([FlutterDeckState? state]) {
    web.window.addEventListener('storage', _onStorageEvent.toJS);

    state != null ? _setState(state) : _sendState();
  }

  @override
  void dispose() {
    _controller.close();

    web.window
      ..removeEventListener('storage', _onStorageEvent.toJS)
      ..localStorage.removeItem(_flutterDeckStateKey);
  }

  @override
  void updateState(FlutterDeckState state) => _setState(state);

  void _setState(FlutterDeckState state) {
    web.window.localStorage.setItem(_flutterDeckStateKey, jsonEncode(state));
  }

  void _onStorageEvent(web.StorageEvent event) {
    if (event.key != _flutterDeckStateKey) return;

    _sendState();
  }

  void _sendState() {
    final state = web.window.localStorage.getItem(_flutterDeckStateKey);

    if (state == null) return;

    final json = jsonDecode(state) as Map<String, dynamic>;

    _controller.add(FlutterDeckState.fromJson(json));
  }
}
```

# WebSocket client example

Source: [flutter_deck_ws_client](https://pub.dev/packages/flutter_deck_ws_client)

```dart
class FlutterDeckWsClient implements FlutterDeckClient {
  FlutterDeckWsClient({
    required this.uri
  });

  final Uri uri;

  late final WebSocket _ws;

  @override
  void init([FlutterDeckState? state]) {
    _ws = WebSocket(uri);

    if (state == null) return;

    _ws.connection
        .firstWhere((connectionState) => connectionState is Connected)
        .then((_) => updateState(state));
  }

  @override
  void dispose() {
    _ws.close();
  }

  @override
  Stream<FlutterDeckState> get flutterDeckStateStream =>
      _ws.messages.cast<String>().map(_toFlutterDeckState);

  @override
  void updateState(FlutterDeckState state) => _ws.send(jsonEncode(state));

  FlutterDeckState _toFlutterDeckState(String state) {
    final json = jsonDecode(state) as Map<String, dynamic>;

    return FlutterDeckState.fromJson(json);
  }
}
```
