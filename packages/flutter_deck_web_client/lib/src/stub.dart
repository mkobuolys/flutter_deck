import 'package:flutter_deck_client/flutter_deck_client.dart';

/// Stub implementation of [FlutterDeckClient].
///
/// This implementation does nothing and returns empty streams. It will be used
/// when the package is imported in non-web platforms.
class FlutterDeckWebClient implements FlutterDeckClient {
  @override
  Stream<FlutterDeckState> get flutterDeckStateStream => const Stream.empty();

  @override
  void init([FlutterDeckState? state]) {}

  @override
  void dispose() {}

  @override
  void updateState(FlutterDeckState state) {}
}
