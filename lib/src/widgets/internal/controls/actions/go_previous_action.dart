import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

///
class GoPreviousIntent extends Intent {
  ///
  const GoPreviousIntent();
}

///
class GoPreviousAction extends FlutterDeckAction<GoPreviousIntent> {
  ///
  GoPreviousAction(super.notifier);

  @override
  Object? invoke(GoPreviousIntent intent) {
    notifier?.previous();

    return null;
  }
}
