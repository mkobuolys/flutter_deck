import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckRouter', () {
    late List<FlutterDeckRouterSlide> slides;
    late FlutterDeckRouter router;

    setUp(() {
      slides = [
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1', steps: 2),
          route: '/slide-1',
          widget: SizedBox(),
        ),
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-2'),
          route: '/slide-2',
          widget: SizedBox(),
        ),
      ];
      router = FlutterDeckRouter(slides: slides);
    });

    test('should have correct initial state', () {
      router.build();
      expect(router.currentSlideIndex, 0);
      expect(router.currentStep, 1);
    });

    test('next() should go to next step if available', () {
      router
        ..build()
        ..next();
      expect(router.currentSlideIndex, 0);
      expect(router.currentStep, 2);
    });

    test('next() should go to next slide if no more steps', () {
      router
        ..build()
        ..next() // Step 2
        ..next(); // Next slide
      expect(router.currentSlideIndex, 1);
      expect(router.currentStep, 1);
    });

    test('next() should do nothing if at end of deck', () {
      router
        ..build()
        ..next() // Step 2 (Slide 1)
        ..next() // Slide 2
        ..next(); // End
      expect(router.currentSlideIndex, 1);
      expect(router.currentStep, 1);
    });

    test('previous() should go to previous step if available', () {
      router
        ..build()
        ..next() // Step 2
        ..previous();
      expect(router.currentSlideIndex, 0);
      expect(router.currentStep, 1);
    });

    test('previous() should go to previous slide if at first step', () {
      router
        ..build()
        ..next() // Step 2 (Slide 1)
        ..next() // Slide 2
        ..previous();
      expect(router.currentSlideIndex, 0);
      expect(router.currentStep, 1);
    });

    test('previous() should do nothing if at start of deck', () {
      router
        ..build()
        ..previous();
      expect(router.currentSlideIndex, 0);
      expect(router.currentStep, 1);
    });

    test('goToSlide() should go to specific slide', () {
      router
        ..build()
        ..goToSlide(2);
      expect(router.currentSlideIndex, 1);
      expect(router.currentStep, 1);
    });

    test('goToSlide() should do nothing if slide number invalid', () {
      router
        ..build()
        ..goToSlide(3);
      expect(router.currentSlideIndex, 0);
      router.goToSlide(0);
      expect(router.currentSlideIndex, 0);
    });

    test('goToStep() should go to specific step', () {
      router
        ..build()
        ..goToStep(2);
      expect(router.currentStep, 2);
    });

    test('goToStep() should do nothing if step number invalid', () {
      router
        ..build()
        ..goToStep(3);
      expect(router.currentStep, 1);
      router.goToStep(0);
      expect(router.currentStep, 1);
    });

    test('build() should assert if duplicate locations found', () {
      final duplicateSlides = [
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1'),
          route: '/slide-1',
          widget: SizedBox(),
        ),
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1'),
          route: '/slide-1',
          widget: SizedBox(),
        ),
      ];
      final router = FlutterDeckRouter(slides: duplicateSlides);

      expect(router.build, throwsAssertionError);
    });

    test('build() should assert if multiple initial slides found', () {
      final initialSlides = [
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1', initial: true),
          route: '/slide-1',
          widget: SizedBox(),
        ),
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-2', initial: true),
          route: '/slide-2',
          widget: SizedBox(),
        ),
      ];
      final router = FlutterDeckRouter(slides: initialSlides);

      expect(router.build, throwsAssertionError);
    });

    test('initial route should be respected', () {
      final initialSlides = [
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1'),
          route: '/slide-1',
          widget: SizedBox(),
        ),
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-2', initial: true),
          route: '/slide-2',
          widget: SizedBox(),
        ),
      ];
      final router = FlutterDeckRouter(slides: initialSlides)..build();

      expect(router.currentSlideIndex, 1);
    });

    test('isPresenterView should be true if passed to build', () {
      router.build(isPresenterView: true);
      expect(router.isPresenterView, true);
    });
  });
}
