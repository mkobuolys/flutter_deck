// This file is conditionally included when compiling to web.

import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';
import 'package:web/web.dart' as web;

/// The web implementation of [WindowProxyBase].
class WindowProxy implements WindowProxyBase {
  @override
  Future<void> initialize() async {
    // No need for initialization
  }

  @override
  bool canFullscreen() => true;

  @override
  Future<bool> isInFullscreen() async => web.document.fullscreenElement != null;

  @override
  Future<void> enterFullscreen() async =>
      web.document.documentElement?.requestFullscreen();

  @override
  Future<void> leaveFullscreen() async => web.document.exitFullscreen();
}
