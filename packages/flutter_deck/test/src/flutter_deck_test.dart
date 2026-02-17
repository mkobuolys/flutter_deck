import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckThemeNotifier>(),
])
import 'flutter_deck_test.mocks.dart';

void main() {
  group('FlutterDeck', () {
    late MockFlutterDeckRouter mockRouter;
    late MockFlutterDeckControlsNotifier mockControlsNotifier;
    late MockFlutterDeckDrawerNotifier mockDrawerNotifier;
    late MockFlutterDeckLocalizationNotifier mockLocalizationNotifier;
    late MockFlutterDeckMarkerNotifier mockMarkerNotifier;
    late MockFlutterDeckPresenterController mockPresenterController;
    late MockFlutterDeckThemeNotifier mockThemeNotifier;
    late FlutterDeck flutterDeck;

    setUp(() {
      mockRouter = MockFlutterDeckRouter();
      mockControlsNotifier = MockFlutterDeckControlsNotifier();
      mockDrawerNotifier = MockFlutterDeckDrawerNotifier();
      mockLocalizationNotifier = MockFlutterDeckLocalizationNotifier();
      mockMarkerNotifier = MockFlutterDeckMarkerNotifier();
      mockPresenterController = MockFlutterDeckPresenterController();
      mockThemeNotifier = MockFlutterDeckThemeNotifier();

      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(),
        router: mockRouter,
        speakerInfo: const FlutterDeckSpeakerInfo(
          name: 'Name',
          description: 'Description',
          socialHandle: 'Social Handle',
          imagePath: 'Image Path',
        ),
        controlsNotifier: mockControlsNotifier,
        drawerNotifier: mockDrawerNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        presenterController: mockPresenterController,
        themeNotifier: mockThemeNotifier,
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
      );
    });

    test('should delegate next() to router', () {
      flutterDeck.next();
      verify(mockRouter.next()).called(1);
    });

    test('should delegate previous() to router', () {
      flutterDeck.previous();
      verify(mockRouter.previous()).called(1);
    });

    test('should delegate goToSlide() to router', () {
      flutterDeck.goToSlide(1);
      verify(mockRouter.goToSlide(1)).called(1);
    });

    test('should delegate goToStep() to router', () {
      flutterDeck.goToStep(1);
      verify(mockRouter.goToStep(1)).called(1);
    });

    test('should return correct properties', () {
      expect(flutterDeck.router, mockRouter);
      expect(flutterDeck.controlsNotifier, mockControlsNotifier);
      expect(flutterDeck.drawerNotifier, mockDrawerNotifier);
      expect(flutterDeck.localizationNotifier, mockLocalizationNotifier);
      expect(flutterDeck.markerNotifier, mockMarkerNotifier);
      expect(flutterDeck.presenterController, mockPresenterController);
      expect(flutterDeck.themeNotifier, mockThemeNotifier);
    });
  });

  group('FlutterDeckProvider', () {
    testWidgets('should provide FlutterDeck to descendants', (tester) async {
      late FlutterDeck flutterDeck;
      final mockRouter = MockFlutterDeckRouter();

      // Need a minimal valid FlutterDeck instance
      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(),
        router: mockRouter,
        speakerInfo: null,
        controlsNotifier: MockFlutterDeckControlsNotifier(),
        drawerNotifier: MockFlutterDeckDrawerNotifier(),
        localizationNotifier: MockFlutterDeckLocalizationNotifier(),
        markerNotifier: MockFlutterDeckMarkerNotifier(),
        presenterController: MockFlutterDeckPresenterController(),
        themeNotifier: MockFlutterDeckThemeNotifier(),
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
      );

      late FlutterDeck result;

      await tester.pumpWidget(
        FlutterDeckProvider(
          flutterDeck: flutterDeck,
          child: Builder(
            builder: (context) {
              result = FlutterDeckProvider.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(result, flutterDeck);
    });
  });
}
