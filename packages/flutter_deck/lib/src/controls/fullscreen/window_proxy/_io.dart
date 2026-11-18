import 'dart:io';

import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';
import 'package:window_manager/window_manager.dart';

/// The dart:io implementation of [WindowProxyBase].
class WindowProxy implements WindowProxyBase {
  Window? get _window => WindowManager.instance.getCurrent();

  @override
  Future<void> initialize() async {}

  @override
  bool canFullscreen() => Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  @override
  Future<bool> isInFullscreen() async => _window?.isFullScreen ?? false;

  @override
  Future<void> enterFullscreen() async => _window?.isFullScreen = true;

  @override
  Future<void> leaveFullscreen() async => _window?.isFullScreen = false;
}
