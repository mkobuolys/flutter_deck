import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_notifier.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'flutter_deck_autoplay_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckAutoplayProvider', () {
    testWidgets('provides notifier down the tree', (tester) async {
      final mockRouter = MockFlutterDeckRouter();
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter);

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckAutoplayProvider(
            notifier: notifier,
            child: Builder(
              builder: (context) {
                final providedNotifier = FlutterDeckAutoplayProvider.of(context);
                expect(providedNotifier, equals(notifier));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('throws if notifier not found', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              FlutterDeckAutoplayProvider.of(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(tester.takeException(), isAssertionError);
    });
  });
}
