import 'package:flutter/widgets.dart';

///
class FlutterDeckMarkerNotifier with ChangeNotifier {
  ///
  FlutterDeckMarkerNotifier();

  var _paths = <List<Offset>>[];
  var _enabled = false;

  ///
  List<List<Offset>> get paths => _paths;

  ///
  bool get enabled => _enabled;

  ///
  void update(int index, Offset offset) {
    if (index == _paths.length) _paths = [..._paths, []];

    final [...paths, currentPath] = _paths;

    _paths = [
      ...paths,
      [...currentPath, offset],
    ];

    notifyListeners();
  }

  ///
  void toggle() {
    _enabled = !_enabled;

    if (!_enabled) _paths = [];

    notifyListeners();
  }
}
