// This file is conditionally included when compiling to web.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Returns whether or not this platform has support to enter/leave fullscreen
bool canFullscreen() => true;

/// Returns whether or not the application is currently fullscreen
bool isInFullscreen() => html.window.document.fullscreenElement != null;

/// Application enters fullscreen
void enterFullscreen() =>
    html.window.document.documentElement?.requestFullscreen();

/// Application leaves fullscreen
void leaveFullscreen() => html.window.document.exitFullscreen();
