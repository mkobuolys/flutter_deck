// This file is conditionally included when compiling to web.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';

/// The web implementation of [FlutterDeckFullscreenManagerBase].
class FlutterDeckFullscreenManager implements FlutterDeckFullscreenManagerBase {
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
