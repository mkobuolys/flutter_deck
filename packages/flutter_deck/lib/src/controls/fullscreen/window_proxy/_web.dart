// This file is conditionally included when compiling to web.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';

/// The web implementation of [WindowProxyBase].
class WindowProxy implements WindowProxyBase {
  @override
  Future<void> initialize() async {
    // No need for initialization
  }

  @override
  bool canFullscreen() => true;

  @override
  Future<bool> isInFullscreen() async =>
      html.window.document.fullscreenElement != null;

  @override
  Future<void> enterFullscreen() async =>
      html.window.document.documentElement?.requestFullscreen();

  @override
  Future<void> leaveFullscreen() async => html.window.document.exitFullscreen();
}
