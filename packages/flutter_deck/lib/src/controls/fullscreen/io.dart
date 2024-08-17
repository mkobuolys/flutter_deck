import 'dart:io';

import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';
import 'package:window_manager/window_manager.dart';

/// The dart:io implementation of [FlutterDeckFullscreenManagerBase].
class FlutterDeckFullscreenManager implements FlutterDeckFullscreenManagerBase {
  bool _initialized = false;

  Future<WindowManager> get _instance async {
    if (!_initialized) {
      await windowManager.ensureInitialized();
      _initialized = true;
    }
    return WindowManager.instance;
  }

  @override
  bool canFullscreen() =>
      Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  @override
  Future<void> enterFullscreen() async {
    final windowManager = await _instance;
    return windowManager.setFullScreen(true);
  }

  @override
  Future<bool> isInFullscreen() async {
    final windowManager = await _instance;
    return windowManager.isFullScreen();
  }

  @override
  Future<void> leaveFullscreen() async {
    final windowManager = await _instance;
    return windowManager.setFullScreen(false);
  }
}
