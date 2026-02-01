import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_notifier.dart';

/// A [InheritedWidget] that provides the [FlutterDeckAutoplayNotifier] to the
/// widget tree.
class FlutterDeckAutoplayProvider extends InheritedWidget {
  /// Creates a [FlutterDeckAutoplayProvider].
  const FlutterDeckAutoplayProvider({required this.notifier, required super.child, super.key});

  /// The [FlutterDeckAutoplayNotifier] provided by this widget.
  final FlutterDeckAutoplayNotifier notifier;

  /// Returns the [FlutterDeckAutoplayNotifier] from the closest
  /// [FlutterDeckAutoplayProvider] ancestor.
  static FlutterDeckAutoplayNotifier of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<FlutterDeckAutoplayProvider>();

    assert(provider != null, 'No FlutterDeckAutoplayProvider found in context');

    return provider!.notifier;
  }

  @override
  bool updateShouldNotify(FlutterDeckAutoplayProvider oldWidget) => notifier != oldWidget.notifier;
}
