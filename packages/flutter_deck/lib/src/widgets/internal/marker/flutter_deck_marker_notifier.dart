import 'package:flutter/widgets.dart';

/// The [ChangeNotifier] used to control the slide deck's marker.
class FlutterDeckMarkerNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckMarkerNotifier].
  FlutterDeckMarkerNotifier();

  var _paths = <List<Offset>>[];
  var _enabled = false;
  var _version = 0;

  /// The paths drawn on the slide.
  List<List<Offset>> get paths => _paths;

  /// Whether the marker is enabled.
  bool get enabled => _enabled;

  /// The current version of the paths.
  int get version => _version;

  /// Add a new [offset] to the path at [index].
  ///
  /// If [index] is equal to the length of the paths, a new path is created.
  void update(int index, Offset offset) {
    if (index == _paths.length) _paths.add([]);

    _paths[index].add(offset);
    _version++;

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
    _version++;

    notifyListeners();
  }
}
