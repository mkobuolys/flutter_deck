import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

///
class ToggleDrawerIntent extends Intent {
  ///
  const ToggleDrawerIntent();
}

///
class ToggleDrawerAction extends FlutterDeckAction<ToggleDrawerIntent> {
  ///
  ToggleDrawerAction(super.notifier);

  @override
  Object? invoke(ToggleDrawerIntent intent) {
    notifier?.toggleDrawer();

    return null;
  }
}
