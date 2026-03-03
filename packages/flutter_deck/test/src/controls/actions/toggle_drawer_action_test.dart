import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'toggle_drawer_action_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckControlsNotifier>()])
void main() {
  group('ToggleDrawerAction', () {
    late final FlutterDeckControlsNotifier mockNotifier;

    setUp(() {
      mockNotifier = MockFlutterDeckControlsNotifier();
    });

    test('invoke should call toggleDrawer on notifier', () {
      ToggleDrawerAction(mockNotifier).invoke(const ToggleDrawerIntent());

      verify(mockNotifier.toggleDrawer()).called(1);
    });
  });
}
