import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_plugin.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_autoplay_plugin_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>(), MockSpec<FlutterDeckRouter>(), MockSpec<FlutterDeckControlsNotifier>()])
void main() {
  group('FlutterDeckAutoplayPlugin', () {
    late MockFlutterDeck mockFlutterDeck;
    late MockFlutterDeckRouter mockRouter;
    late MockFlutterDeckControlsNotifier mockControlsNotifier;

    setUp(() {
      mockFlutterDeck = MockFlutterDeck();
      mockRouter = MockFlutterDeckRouter();
      mockControlsNotifier = MockFlutterDeckControlsNotifier();

      when(mockFlutterDeck.router).thenReturn(mockRouter);
      when(mockFlutterDeck.controlsNotifier).thenReturn(mockControlsNotifier);
      when(mockControlsNotifier.controlsVisible).thenReturn(false);
    });

    test('init and dispose manage listeners', () {
      final plugin = FlutterDeckAutoplayPlugin()..init(mockFlutterDeck);
      verify(mockControlsNotifier.addListener(any)).called(1);

      plugin.dispose();
      verify(mockControlsNotifier.removeListener(any)).called(1);
    });

    testWidgets('wrap provides AutoplayProvider', (tester) async {
      final plugin = FlutterDeckAutoplayPlugin()..init(mockFlutterDeck);

      await tester.pumpWidget(MaterialApp(home: plugin.wrap(MockBuildContext(), const Text('ChildWidget'))));

      expect(find.byType(FlutterDeckAutoplayProvider), findsOneWidget);
      expect(find.text('ChildWidget'), findsOneWidget);
    });

    test('buildControls returns menu items', () {
      final plugin = FlutterDeckAutoplayPlugin()..init(mockFlutterDeck);

      final controls = plugin.buildControls(MockBuildContext(), (
        context, {
        required String label,
        required VoidCallback? onPressed,
        Widget? icon,
        bool? closeOnActivate,
      }) {
        return const SizedBox();
      });

      expect(controls.length, 1);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
