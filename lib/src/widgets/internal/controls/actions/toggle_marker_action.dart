import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/flutter_deck_action.dart';

/// An [Intent] that is bound to a [ToggleMarkerAction].
class ToggleMarkerIntent extends Intent {
  /// Default constructor for [ToggleMarkerIntent].
  const ToggleMarkerIntent();
}

/// An [Action] that can be used to toggle the slide deck's marker.
class ToggleMarkerAction extends FlutterDeckAction<ToggleMarkerIntent> {
  /// Default constructor for [ToggleMarkerAction].
  ToggleMarkerAction(super.notifier);

  @override
  Object? invoke(ToggleMarkerIntent intent) {
    notifier?.toggleMarker();

    return null;
  }
}
