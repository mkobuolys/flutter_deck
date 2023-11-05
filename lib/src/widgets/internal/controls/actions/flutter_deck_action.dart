import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/flutter_deck_controls_notifier.dart';

/// Base class for an action that can be performed on the slide deck.
///
/// The main purpose of this class is to disable shortcuts automatically when
/// the corresponding action is disabled.
abstract class FlutterDeckAction<T extends Intent> extends Action<T> {
  /// Default constructor for [FlutterDeckAction].
  FlutterDeckAction([this.notifier]);

  /// The [FlutterDeckControlsNotifier] used to control the slide deck.
  final FlutterDeckControlsNotifier? notifier;

  @override
  bool isEnabled(T intent) {
    if (notifier?.intentDisabled(intent) ?? false) return false;

    return super.isEnabled(intent);
  }
}
