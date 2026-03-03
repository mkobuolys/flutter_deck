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

      ToggleDrawerAction(mockNotifier).invoke(const ToggleDrawerIntent());

      verify(mockNotifier.toggleDrawer()).called(1);
    });
  });
}
