import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

/// An [Intent] that is bound to a [ToggleDrawerAction].
class ToggleDrawerIntent extends Intent {
  /// Default constructor for [ToggleDrawerIntent].
  const ToggleDrawerIntent();
}

/// An [Action] that can be used to toggle the slide deck's drawer.
class ToggleDrawerAction extends FlutterDeckAction<ToggleDrawerIntent> {
  /// Default constructor for [ToggleDrawerAction].
  ToggleDrawerAction(super.notifier);

  @override
  Object? invoke(ToggleDrawerIntent intent) {
    notifier?.toggleDrawer();

    return null;
  }
}
