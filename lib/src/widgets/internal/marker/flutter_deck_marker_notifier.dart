import 'package:flutter/widgets.dart';

/// The [ChangeNotifier] used to control the slide deck's marker.
class FlutterDeckMarkerNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckMarkerNotifier].
  FlutterDeckMarkerNotifier();

  var _paths = <List<Offset>>[];
  var _enabled = false;

  /// The paths drawn on the slide.
  List<List<Offset>> get paths => _paths;

  /// Whether the marker is enabled.
  bool get enabled => _enabled;

  /// Add a new [offset] to the path at [index].
  ///
  /// If [index] is equal to the length of the paths, a new path is created.
  void update(int index, Offset offset) {
    if (index == _paths.length) _paths = [..._paths, []];

    final [...paths, currentPath] = _paths;

    _paths = [
      ...paths,
      [...currentPath, offset],
    ];

    notifyListeners();
  }

  /// Toggle the marker.
  void toggle() {
    _enabled = !_enabled;

    clear();
  }

  /// Clear the paths.
  void clear() {
    _paths = [];

    notifyListeners();
  }
}
