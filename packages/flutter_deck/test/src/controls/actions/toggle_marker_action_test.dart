import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'toggle_marker_action_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckControlsNotifier>()])
void main() {
  group('ToggleMarkerAction', () {
    late final FlutterDeckControlsNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockFlutterDeckControlsNotifier();
    });

    test('invoke should call toggleMarker on notifier', () {
      ToggleMarkerAction(mockNotifier).invoke(const ToggleMarkerIntent());

      verify(mockNotifier.toggleMarker()).called(1);
    });
  });
}
