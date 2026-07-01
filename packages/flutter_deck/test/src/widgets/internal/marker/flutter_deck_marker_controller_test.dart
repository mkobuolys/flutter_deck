import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_controller.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckMarkerController', () {
    late FlutterDeckMarkerNotifier markerNotifier;

    FlutterDeckRouter buildRouter({int steps = 1}) => FlutterDeckRouter(
      slides: [
        FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1', steps: steps),
          route: '/slide-1',
          widget: const SizedBox(),
        ),
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-2'),
          route: '/slide-2',
          widget: SizedBox(),
        ),
      ],
    )..build();

    setUp(() => markerNotifier = FlutterDeckMarkerNotifier());

    test('clears drawings on slide change when persistence is disabled', () {
      final router = buildRouter();
      FlutterDeckMarkerController(router: router, markerNotifier: markerNotifier, persist: false).init();

      markerNotifier.startPath('/slide-1', const Offset(1, 1));
      router.next();

      expect(markerNotifier.pathsForSlide('/slide-1'), isEmpty);
    });

    test('does not clear drawings on step change', () {
      final router = buildRouter(steps: 2);
      FlutterDeckMarkerController(router: router, markerNotifier: markerNotifier, persist: false).init();

      markerNotifier.startPath('/slide-1', const Offset(1, 1));
      router.next(); // advances the step, not the slide

      expect(markerNotifier.pathsForSlide('/slide-1'), isNotEmpty);
    });

    test('keeps drawings on slide change when persistence is enabled', () {
      final router = buildRouter();
      FlutterDeckMarkerController(router: router, markerNotifier: markerNotifier, persist: true).init();

      markerNotifier.startPath('/slide-1', const Offset(1, 1));
      router.next();

      expect(markerNotifier.pathsForSlide('/slide-1'), isNotEmpty);
    });

    test('stops clearing after dispose', () {
      final router = buildRouter();
      FlutterDeckMarkerController(router: router, markerNotifier: markerNotifier, persist: false)
        ..init()
        ..dispose();

      markerNotifier.startPath('/slide-1', const Offset(1, 1));
      router.next();

      expect(markerNotifier.pathsForSlide('/slide-1'), isNotEmpty);
    });
  });
}
