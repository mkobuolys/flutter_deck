import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';

/// The stub implementation of [WindowProxyBase].
class WindowProxy implements WindowProxyBase {
  @override
  Future<void> initialize() => throw UnsupportedError('initialize cannot be called on this platform');

  /// Returns whether or not this platform has support to enter/leave fullscreen
  @override
  bool canFullscreen() => false;

  /// Returns whether or not the application is currently fullscreen
  @override
  Future<bool> isInFullscreen() => throw UnsupportedError('isInFullscreen cannot be called on this platform');

  /// Application enters fullscreen
  @override
  Future<void> enterFullscreen() => throw UnsupportedError('enterFullscreen cannot be called on this platform');

  /// Application leaves fullscreen
  @override
  Future<void> leaveFullscreen() => throw UnsupportedError('leaveFullscreen cannot be called on this platform');
}
