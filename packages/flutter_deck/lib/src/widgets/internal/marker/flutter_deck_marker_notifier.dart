import 'package:flutter/widgets.dart';

/// The [ChangeNotifier] used to control the slide deck's marker.
///
/// Drawn paths are stored per slide (keyed by the slide's route) so that
/// annotations are preserved when toggling the marker off or navigating between
/// slides. Paths are only removed for a slide through an explicit [clear].
class FlutterDeckMarkerNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckMarkerNotifier].
  FlutterDeckMarkerNotifier();

  final _pathsBySlide = <String, List<List<Offset>>>{};
  var _enabled = false;
  var _version = 0;

  /// Whether the marker is enabled.
  bool get enabled => _enabled;

  /// The current version of the paths.
  int get version => _version;

  /// The paths drawn on the slide with the given [route].
  List<List<Offset>> pathsForSlide(String route) => _pathsBySlide[route] ?? const [];

  /// Start a new path on the slide with the given [route] at [offset].
  void startPath(String route, Offset offset) {
    _pathsBySlide.putIfAbsent(route, () => []).add([offset]);
    _version++;

    notifyListeners();
  }

  /// Add [offset] to the current (last) path on the slide with the given
  /// [route].
  ///
  /// Does nothing if no path has been started for the slide.
  void addPoint(String route, Offset offset) {
    final paths = _pathsBySlide[route];

    if (paths == null || paths.isEmpty) return;

    paths.last.add(offset);
    _version++;

    notifyListeners();
  }

  /// Toggle the marker.
  ///
  /// Toggling the marker does not erase any drawn paths.
  void toggle() {
    _enabled = !_enabled;

    notifyListeners();
  }

  /// Clear the paths drawn on the slide with the given [route].
  void clear(String route) {
    _pathsBySlide.remove(route);
    _version++;

    notifyListeners();
  }

  /// Clear the paths drawn on all slides.
  void clearAll() {
    if (_pathsBySlide.isEmpty) return;

    _pathsBySlide.clear();
    _version++;

    notifyListeners();
  }
}
