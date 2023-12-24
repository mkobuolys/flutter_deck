import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/actions/flutter_deck_action.dart';

/// An [Intent] that is bound to a [GoNextAction].
class GoNextIntent extends Intent {
  /// Default constructor for [GoNextIntent].
  const GoNextIntent();
}

/// An [Action] that can be used to go to the next slide.
class GoNextAction extends FlutterDeckAction<GoNextIntent> {
  /// Default constructor for [GoNextAction].
  GoNextAction(super.notifier);

  @override
  Object? invoke(GoNextIntent intent) {
    notifier?.next();

    return null;
  }
}
