export 'stub.dart'
    if (dart.library.io) 'io.dart'
    if (dart.library.html) 'web.dart';

/// Describes a collection of functions that can mutate and retrieve
/// the application's fullscreen state.
abstract class FlutterDeckFullscreenManagerBase {
  /// Returns whether or not this platform has support to enter/leave fullscreen
  bool canFullscreen() => false;

  /// Returns whether or not the application is currently fullscreen
  bool isInFullscreen() => throw UnsupportedError(
        'isInFullscreen cannot be called on this platform',
      );

  /// Application enters fullscreen
  void enterFullscreen() => throw UnsupportedError(
        'enterFullscreen cannot be called on this platform',
      );

  /// Application leaves fullscreen
  void leaveFullscreen() => throw UnsupportedError(
        'leaveFullscreen cannot be called on this platform',
      );
}
