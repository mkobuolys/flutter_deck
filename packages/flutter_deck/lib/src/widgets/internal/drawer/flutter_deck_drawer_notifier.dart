import 'package:flutter/widgets.dart';

/// The [ChangeNotifier] used to toggle the drawer of the slide deck.
///
/// This is used internally only.
class FlutterDeckDrawerNotifier with ChangeNotifier {
  /// Creates a [FlutterDeckDrawerNotifier].
  FlutterDeckDrawerNotifier();

  /// Notifies the listeners to trigger drawer toggle.
  void toggle() => notifyListeners();
}
