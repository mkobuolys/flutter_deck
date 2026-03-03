import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_slide_preview.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_timer.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_speaker_notes.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_presenter_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeck>(),
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
])
void main() {
  group('PresenterView', () {
    late MockFlutterDeck mockDeck;
    late MockFlutterDeckRouter mockRouter;
    late MockFlutterDeckPresenterController mockController;
    late MockFlutterDeckControlsNotifier mockControlsNotifier;
    late MockFlutterDeckDrawerNotifier mockDrawerNotifier;

    setUp(() {
      mockDeck = MockFlutterDeck();
      mockRouter = MockFlutterDeckRouter();
      mockController = MockFlutterDeckPresenterController();
      mockControlsNotifier = MockFlutterDeckControlsNotifier();
      mockDrawerNotifier = MockFlutterDeckDrawerNotifier();

      when(mockRouter.currentSlideIndex).thenReturn(0);
      when(mockRouter.currentStep).thenReturn(1);
      when(
        mockRouter.currentSlideConfiguration,
      ).thenReturn(const FlutterDeckSlideConfiguration(route: '/1', steps: 1, speakerNotes: 'Some notes'));
      when(mockRouter.slides).thenReturn([
        const FlutterDeckRouterSlide(
          route: '/1',
          widget: SizedBox(),
          configuration: FlutterDeckSlideConfiguration(route: '/1', speakerNotes: 'Some notes'),
        ),
      ]);

      when(mockDeck.router).thenReturn(mockRouter);
      when(mockDeck.presenterController).thenReturn(mockController);
      when(mockDeck.controlsNotifier).thenReturn(mockControlsNotifier);
      when(mockDeck.drawerNotifier).thenReturn(mockDrawerNotifier);
      when(mockDeck.globalConfiguration).thenReturn(const FlutterDeckConfiguration());

      when(mockControlsNotifier.controlsVisible).thenReturn(false);
    });

    testWidgets('builds presenterView correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckTheme(
            data: FlutterDeckThemeData.light(),
            child: FlutterDeckProvider(flutterDeck: mockDeck, child: const PresenterView()),
          ),
        ),
      );

      verify(mockController.init()).called(1);

      expect(find.byType(FlutterDeckPresenterTimer), findsOneWidget);
      expect(find.byType(FlutterDeckPresenterSlidePreview), findsOneWidget);
      expect(find.byType(FlutterDeckSpeakerNotes), findsOneWidget);

      expect(find.text('Some notes'), findsOneWidget);
    });

    testWidgets('disposes controller correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckTheme(
            data: FlutterDeckThemeData.light(),
            child: FlutterDeckProvider(flutterDeck: mockDeck, child: const PresenterView()),
          ),
        ),
      );

      verify(mockController.init()).called(1);

      await tester.pumpWidget(const SizedBox());

      verify(mockController.dispose()).called(1);
    });
  });
}
