import 'package:flutter_deck/src/controls/actions/toggle_drawer_action.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'toggle_drawer_action_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckControlsNotifier>()])
void main() {
  group('ToggleDrawerAction', () {
    test('invoke should call toggleDrawer on notifier', () {
      final mockNotifier = MockFlutterDeckControlsNotifier();
      final action = ToggleDrawerAction(mockNotifier);

      final result = action.invoke(const ToggleDrawerIntent());

      verify(mockNotifier.toggleDrawer()).called(1);
      expect(result, isNull);
    });
  });
}
