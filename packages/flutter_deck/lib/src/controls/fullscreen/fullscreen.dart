import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';

/// Describes a collection of functions that can mutate and retrieve
/// the application's fullscreen state.
class FlutterDeckFullscreenManager {
  /// Default constructor for [FlutterDeckFullscreenManager].
  ///
  /// The [windowProxy] is required for getting and setting window properties
  /// from underlying platform.
  ///
  FlutterDeckFullscreenManager(WindowProxyBase windowProxy)
      : _windowProxy = windowProxy;

  final WindowProxyBase _windowProxy;
  bool _initialized = false;

  Future<WindowProxyBase> get _instance async {
    if (!_initialized) {
      await _windowProxy.initialize();
      _initialized = true;
    }
    return _windowProxy;
  }

  /// Returns whether or not this platform has support to enter/leave fullscreen
  bool canFullscreen() => _windowProxy.canFullscreen();

  /// Returns whether or not the application is currently fullscreen
  Future<bool> isInFullscreen() async {
    final windowProxy = await _instance;
    return windowProxy.isInFullscreen();
  }

  /// Application enters fullscreen
  Future<void> enterFullscreen() async {
    final windowProxy = await _instance;
    await windowProxy.enterFullscreen();
  }

  /// Application leaves fullscreen
  Future<void> leaveFullscreen() async {
    final windowProxy = await _instance;
    await windowProxy.leaveFullscreen();
  }
}
