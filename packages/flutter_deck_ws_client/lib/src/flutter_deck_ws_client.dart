import 'dart:convert';

import 'package:flutter_deck_client/flutter_deck_client.dart';
import 'package:web_socket_client/web_socket_client.dart';

/// WebSocket implementation of [FlutterDeckClient].
///
/// This implementation uses a WebSocket connection to share the state between
/// the flutter_deck presentation and the presenter view.
///
/// The WebSocket server is expected to echo the state back to the client when
/// it receives a state update.
class FlutterDeckWsClient implements FlutterDeckClient {
  /// Creates a new [FlutterDeckWsClient].
  FlutterDeckWsClient({required this.uri});

  /// The URI of the WebSocket server.
  final Uri uri;

  late final WebSocket _ws;

  @override
  void init([FlutterDeckState? state]) {
    _ws = WebSocket(uri);

    if (state == null) return;

    _ws.connection.firstWhere((connectionState) => connectionState is Connected).then((_) => updateState(state));
  }

  @override
  void dispose() {
    _ws.close();
  }

  @override
  Stream<FlutterDeckState> get flutterDeckStateStream => _ws.messages.cast<String>().map(_toFlutterDeckState);

  @override
  void updateState(FlutterDeckState state) => _ws.send(jsonEncode(state));

  FlutterDeckState _toFlutterDeckState(String state) {
    final json = jsonDecode(state) as Map<String, dynamic>;

    return FlutterDeckState.fromJson(json);
  }
}
