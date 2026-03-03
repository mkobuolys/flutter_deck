import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/flutter_deck_presenter_controller.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_deck_client/flutter_deck_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_presenter_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckThemeNotifier>(),
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckClient>(),
])
void main() {
  group('FlutterDeckPresenterController', () {
    late MockFlutterDeckControlsNotifier mockControlsNotifier;
    late MockFlutterDeckLocalizationNotifier mockLocalizationNotifier;
    late MockFlutterDeckMarkerNotifier mockMarkerNotifier;
    late MockFlutterDeckThemeNotifier mockThemeNotifier;
    late MockFlutterDeckRouter mockRouter;
    late MockFlutterDeckClient mockClient;
    late StreamController<FlutterDeckState> stateController;

    setUp(() {
      mockControlsNotifier = MockFlutterDeckControlsNotifier();
      mockLocalizationNotifier = MockFlutterDeckLocalizationNotifier();
      mockMarkerNotifier = MockFlutterDeckMarkerNotifier();
      mockThemeNotifier = MockFlutterDeckThemeNotifier();
      mockRouter = MockFlutterDeckRouter();
      mockClient = MockFlutterDeckClient();
      stateController = StreamController<FlutterDeckState>.broadcast();

      when(mockLocalizationNotifier.value).thenReturn(const Locale('en'));
      when(mockThemeNotifier.value).thenReturn(ThemeMode.dark);
      when(mockRouter.currentSlideIndex).thenReturn(0);
      when(mockRouter.currentStep).thenReturn(1);
      when(mockRouter.isPresenterView).thenReturn(false);
      when(mockClient.flutterDeckStateStream).thenAnswer((_) => stateController.stream);
    });

    tearDown(() {
      stateController.close();
    });

    test('init should do nothing if client is null', () {
      final controller = FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
      )..init();

      expect(controller.available, isFalse);
    });

    test('init should initialize client and add listeners', () {
      final controller = FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
        client: mockClient,
      )..init();

      expect(controller.available, isTrue);
      verify(mockClient.init(any)).called(1);
      verify(mockLocalizationNotifier.addListener(any)).called(1);
      verify(mockMarkerNotifier.addListener(any)).called(1);
      verify(mockThemeNotifier.addListener(any)).called(1);
      verify(mockRouter.addListener(any)).called(1);
    });

    test('init when already initialized should update state if not presenter view', () {
      final controller = FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
        client: mockClient,
      )..init();
      verify(mockClient.init(any)).called(1);

      controller.init();
      verify(mockClient.updateState(any)).called(1);
    });

    test('dispose should cancel subscription and remove listeners', () {
      FlutterDeckPresenterController(
          controlsNotifier: mockControlsNotifier,
          localizationNotifier: mockLocalizationNotifier,
          markerNotifier: mockMarkerNotifier,
          themeNotifier: mockThemeNotifier,
          router: mockRouter,
          client: mockClient,
        )
        ..init()
        ..dispose();

      verify(mockClient.dispose()).called(1);
      verify(mockLocalizationNotifier.removeListener(any)).called(1);
      verify(mockMarkerNotifier.removeListener(any)).called(1);
      verify(mockThemeNotifier.removeListener(any)).called(1);
      verify(mockRouter.removeListener(any)).called(1);
    });

    test('open should open presenter view', () {
      FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
        client: mockClient,
      ).open();

      verify(mockClient.openPresenterView()).called(1);
    });

    test('listeners should notify client with updated state', () {
      FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
        client: mockClient,
      ).init();

      // Clear the initial client.init call if we want to just check updateState
      clearInteractions(mockClient);

      // Simulate route change
      when(mockRouter.currentSlideIndex).thenReturn(1);
      final onRouteChanged = verify(mockRouter.addListener(captureAny)).captured.first as VoidCallback;
      onRouteChanged();
      verify(mockClient.updateState(any)).called(1);

      // Simulate localization change
      when(mockLocalizationNotifier.value).thenReturn(const Locale('es'));
      final onLocalizationChanged =
          verify(mockLocalizationNotifier.addListener(captureAny)).captured.first as VoidCallback;
      onLocalizationChanged();
      verify(mockClient.updateState(any)).called(1);

      // Simulate marker change
      when(mockMarkerNotifier.enabled).thenReturn(true);
      final onMarkerStateChanged = verify(mockMarkerNotifier.addListener(captureAny)).captured.first as VoidCallback;
      onMarkerStateChanged();
      verify(mockClient.updateState(any)).called(1);

      // Simulate theme change
      when(mockThemeNotifier.value).thenReturn(ThemeMode.light);
      final onThemeChanged = verify(mockThemeNotifier.addListener(captureAny)).captured.first as VoidCallback;
      onThemeChanged();
      verify(mockClient.updateState(any)).called(1);
    });

    test('_onStateChanged updates local notifiers', () async {
      FlutterDeckPresenterController(
        controlsNotifier: mockControlsNotifier,
        localizationNotifier: mockLocalizationNotifier,
        markerNotifier: mockMarkerNotifier,
        themeNotifier: mockThemeNotifier,
        router: mockRouter,
        client: mockClient,
      ).init();

      const newState = FlutterDeckState(
        slideIndex: 2,
        slideStep: 3,
        locale: 'es',
        markerEnabled: true,
        themeMode: 'light',
      );

      stateController.add(newState);
      await Future<void>.delayed(Duration.zero); // Wait for stream event

      verify(mockControlsNotifier.goToSlide(3)).called(1);
      verify(mockControlsNotifier.goToStep(3)).called(1);
      verify(mockLocalizationNotifier.update(const Locale('es'))).called(1);
      verify(mockControlsNotifier.toggleMarker()).called(1);
      verify(mockThemeNotifier.update(ThemeMode.light)).called(1);
    });
  });
}
