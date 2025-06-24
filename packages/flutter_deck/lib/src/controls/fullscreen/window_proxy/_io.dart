import 'dart:io';

import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';
import 'package:window_manager/window_manager.dart';

/// The dart:io implementation of [WindowProxyBase].
class WindowProxy implements WindowProxyBase {
  @override
  Future<void> initialize() => windowManager.ensureInitialized();

  @override
  bool canFullscreen() => Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  @override
  Future<bool> isInFullscreen() => windowManager.isFullScreen();

  @override
  Future<void> enterFullscreen() => windowManager.setFullScreen(true);

  @override
  Future<void> leaveFullscreen() => windowManager.setFullScreen(false);
}
