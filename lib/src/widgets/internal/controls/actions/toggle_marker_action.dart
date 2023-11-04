import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

///
class ToggleMarkerIntent extends Intent {
  ///
  const ToggleMarkerIntent();
}

///
class ToggleMarkerAction extends FlutterDeckAction<ToggleMarkerIntent> {
  ///
  ToggleMarkerAction(super.notifier);

  @override
  Object? invoke(ToggleMarkerIntent intent) {
    notifier?.toggleMarker();

    return null;
  }
}
