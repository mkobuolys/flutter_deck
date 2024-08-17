import 'dart:io';

import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';
import 'package:window_manager/window_manager.dart';

/// The dart:io implementation of [FlutterDeckFullscreenManagerBase].
class FlutterDeckFullscreenManager implements FlutterDeckFullscreenManagerBase {
  @override
  bool canFullscreen() =>
      Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  @override
  Future<void> enterFullscreen() => WindowManager.instance.setFullScreen(true);

  @override
  Future<bool> isInFullscreen() async {
    await windowManager.ensureInitialized();
    return WindowManager.instance.isFullScreen();
  }

  @override
  Future<void> leaveFullscreen() => WindowManager.instance.setFullScreen(false);
}
