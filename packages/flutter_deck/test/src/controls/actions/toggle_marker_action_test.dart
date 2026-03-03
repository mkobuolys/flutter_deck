import 'package:flutter_deck/src/controls/actions/toggle_marker_action.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'toggle_marker_action_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckControlsNotifier>()])
void main() {
  group('ToggleMarkerAction', () {
    test('invoke should call toggleMarker on notifier', () {
      final mockNotifier = MockFlutterDeckControlsNotifier();

      ToggleMarkerAction(mockNotifier).invoke(const ToggleMarkerIntent());

      verify(mockNotifier.toggleMarker()).called(1);
    });
  });
}
