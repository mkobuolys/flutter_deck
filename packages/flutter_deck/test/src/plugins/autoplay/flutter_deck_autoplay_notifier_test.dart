import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/plugins/autoplay/autoplay.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_deck_autoplay_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckRouter>()])
void main() {
  group('FlutterDeckAutoplayNotifier', () {
    late MockFlutterDeckRouter mockRouter;

    setUp(() {
      mockRouter = MockFlutterDeckRouter();

      when(mockRouter.currentSlideIndex).thenReturn(0);
      when(mockRouter.currentStep).thenReturn(1);
      when(mockRouter.slides).thenReturn([
        const FlutterDeckRouterSlide(
          route: '/1',
          widget: SizedBox(),
          configuration: FlutterDeckSlideConfiguration(route: '/1'),
        ),
      ]);
      when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/1'));
    });

    test('initial state is correct', () {
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter);

      expect(notifier.isPlaying, isFalse);
      expect(notifier.isLooping, isFalse);
      expect(notifier.autoplayDuration, const Duration(seconds: 5));
    });

    test('play changes isPlaying to true', () {
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter);

      var listenerCalled = false;

      notifier
        ..addListener(() => listenerCalled = true)
        ..play();

      expect(notifier.isPlaying, isTrue);
      expect(listenerCalled, isTrue);

      notifier.pause();
    });

    test('pause changes isPlaying to false', () {
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter)..play();

      var listenerCalled = false;

      notifier
        ..addListener(() => listenerCalled = true)
        ..pause();

      expect(notifier.isPlaying, isFalse);
      expect(listenerCalled, isTrue);
    });

    test('toggleLooping toggles isLooping', () {
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter);

      var listenerCalled = false;

      notifier
        ..addListener(() => listenerCalled = true)
        ..toggleLooping();

      expect(notifier.isLooping, isTrue);
      expect(listenerCalled, isTrue);

      notifier.toggleLooping();

      expect(notifier.isLooping, isFalse);
    });

    test('updateAutoplayDuration updates duration and restarts if playing', () {
      final notifier = FlutterDeckAutoplayNotifier(router: mockRouter)..play();

      var listenerCalled = false;

      notifier
        ..addListener(() => listenerCalled = true)
        ..updateAutoplayDuration(const Duration(seconds: 10));

      expect(notifier.autoplayDuration, const Duration(seconds: 10));
      expect(listenerCalled, isTrue);
      expect(notifier.isPlaying, isTrue);

      notifier.pause();
    });
  });
}
