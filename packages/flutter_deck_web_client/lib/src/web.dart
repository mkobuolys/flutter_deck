import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter_deck_client/flutter_deck_client.dart';
import 'package:web/web.dart' as web;

const _flutterDeckStateKey = 'flutter-deck-state';

/// Web implementation of [FlutterDeckClient].
///
/// This implementation uses the browser's local storage to store the state,
/// which allows the state to be shared between the flutter_deck presentation
/// and the presenter view.
class FlutterDeckWebClient implements FlutterDeckClient {
  /// Creates a new [FlutterDeckWebClient].
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
