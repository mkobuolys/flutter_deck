/// Returns whether or not this platform has support to enter/leave fullscreen
bool canFullscreen() => false;

/// Returns whether or not the application is currently fullscreen
bool isInFullscreen() =>
    throw UnsupportedError('isInFullscreen cannot be called on this platform');

/// Application enters fullscreen
void enterFullscreen() =>
    throw UnsupportedError('enterFullscreen cannot be called on this platform');

/// Application leaves fullscreen
void leaveFullscreen() =>
    throw UnsupportedError('leaveFullscreen cannot be called on this platform');
