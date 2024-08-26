export '_stub.dart'
    if (dart.library.io) '_io.dart'
    if (dart.library.html) '_web.dart';

/// Thin proxy/wrapper around platform specific window API implementation
abstract class WindowProxyBase {
  /// Initializes window API
  Future<void> initialize();

  /// Returns whether or not this platform has support to enter/leave fullscreen
  bool canFullscreen();

  /// Application enters fullscreen
  Future<void> enterFullscreen();

  /// Returns whether or not the application is currently fullscreen
  Future<bool> isInFullscreen();

  /// Application leaves fullscreen
  Future<void> leaveFullscreen();
}
