import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// An inherited widget that provides the [FlutterDeck] to its descendants.
class InheritedFlutterDeck extends InheritedWidget {
  /// Default constructor for [InheritedFlutterDeck].
  ///
  /// The [flutterDeck] and [child] arguments must not be null.
  const InheritedFlutterDeck({
    required this.flutterDeck,
    required super.child,
    super.key,
  });

  /// The [FlutterDeck] to provide to its descendants.
  final FlutterDeck flutterDeck;

  @override
  bool updateShouldNotify(InheritedFlutterDeck oldWidget) =>
      flutterDeck != oldWidget.flutterDeck;
}
