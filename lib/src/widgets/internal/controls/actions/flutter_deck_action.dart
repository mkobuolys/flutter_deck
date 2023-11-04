import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/flutter_deck_controls_notifier.dart';

///
abstract class FlutterDeckAction<T extends Intent> extends Action<T> {
  ///
  FlutterDeckAction([this.notifier]);

  ///
  final FlutterDeckControlsNotifier? notifier;

  @override
  bool isEnabled(T intent) {
    if (notifier?.intentDisabled(intent) ?? false) return false;

    return super.isEnabled(intent);
  }
}
