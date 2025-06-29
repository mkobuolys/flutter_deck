import 'package:flutter_deck_client/src/models/models.dart';

/// A common client interface for the flutter_deck package.
///
/// To implement a custom client, implement this interface and use it in your
/// flutter_deck presentation.
abstract interface class FlutterDeckClient {
  /// Initializes the client with the given [state].
  ///
  /// In flutter_deck, the presentation will call this method with the initial
  /// state of the presentation. The presenter view will also call this method,
  /// but with a null state.
  void init([FlutterDeckState? state]);

  /// Disposes the client.
  ///
  /// This method should be called when the client is no longer needed.
  void dispose();

  /// Opens the presenter view.
  ///
  /// This method is called from the presentation view to open the presenter
  /// view.
  void openPresenterView();

  /// Updates the client state with the given [state].
  ///
  /// This method is called by both the presentation and the presenter view to
  /// keep the [FlutterDeckState] in sync.
  void updateState(FlutterDeckState state);

  /// Returns the state as a stream of [FlutterDeckState] objects.
  ///
  /// This stream is used by flutter_deck framework to keep the presentation and
  /// the presenter view in sync.
  Stream<FlutterDeckState> get flutterDeckStateStream;
}
