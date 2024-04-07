// This file is conditionally included when compiling to web.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';

/// The web implementation of [FlutterDeckFullscreenManagerBase].
class FlutterDeckFullscreenManager implements FlutterDeckFullscreenManagerBase {
  @override
  bool canFullscreen() => true;

  @override
  bool isInFullscreen() => html.window.document.fullscreenElement != null;

  @override
  void enterFullscreen() =>
      html.window.document.documentElement?.requestFullscreen();

  @override
  void leaveFullscreen() => html.window.document.exitFullscreen();
}
