import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

/// An [Intent] that is bound to a [GoPreviousAction].
class GoPreviousIntent extends Intent {
  /// Default constructor for [GoPreviousIntent].
  const GoPreviousIntent();
}

/// An [Action] that can be used to go to the previous slide.
class GoPreviousAction extends FlutterDeckAction<GoPreviousIntent> {
  /// Default constructor for [GoPreviousAction].
  GoPreviousAction(super.notifier);

  @override
  Object? invoke(GoPreviousIntent intent) {
    notifier?.previous();

    return null;
  }
}
