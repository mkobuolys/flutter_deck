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

  /// Add a new [offset] to the path at [index] for the slide with the given
  /// [route].
  ///
  /// If [index] is equal to the length of the paths, a new path is created.
  void update(String route, int index, Offset offset) {
    final paths = _pathsBySlide.putIfAbsent(route, () => []);

    if (index == paths.length) paths.add([]);

    paths[index].add(offset);
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
