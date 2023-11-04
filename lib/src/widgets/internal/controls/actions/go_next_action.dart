import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

///
class GoNextIntent extends Intent {
  ///
  const GoNextIntent();
}

///
class GoNextAction extends FlutterDeckAction<GoNextIntent> {
  ///
  GoNextAction(super.notifier);

  @override
  Object? invoke(GoNextIntent intent) {
    notifier?.next();

    return null;
  }
}
