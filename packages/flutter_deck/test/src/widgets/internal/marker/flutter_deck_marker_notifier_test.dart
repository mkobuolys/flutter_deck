import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckMarkerNotifier', () {
    const routeA = '/a';
    const routeB = '/b';

    late FlutterDeckMarkerNotifier notifier;

    setUp(() => notifier = FlutterDeckMarkerNotifier());

    test('is disabled with no paths initially', () {
      expect(notifier.enabled, isFalse);
      expect(notifier.pathsForSlide(routeA), isEmpty);
    });

    test('startPath() and addPoint() build a path per slide route', () {
      notifier
        ..startPath(routeA, const Offset(1, 1))
        ..addPoint(routeA, const Offset(2, 2));

      expect(notifier.pathsForSlide(routeA), [
        [const Offset(1, 1), const Offset(2, 2)],
      ]);
      expect(notifier.pathsForSlide(routeB), isEmpty);
    });

    test('startPath() creates a new path each time', () {
      notifier
        ..startPath(routeA, const Offset(1, 1))
        ..startPath(routeA, const Offset(2, 2));

      expect(notifier.pathsForSlide(routeA), hasLength(2));
    });

    test('addPoint() does nothing when no path has been started', () {
      var notifications = 0;
      notifier
        ..addListener(() => notifications++)
        ..addPoint(routeA, const Offset(1, 1));

      expect(notifier.pathsForSlide(routeA), isEmpty);
      expect(notifications, 0);
    });

    test('toggle() flips enabled without erasing paths', () {
      notifier
        ..startPath(routeA, const Offset(1, 1))
        ..toggle();

      expect(notifier.enabled, isTrue);
      expect(notifier.pathsForSlide(routeA), isNotEmpty);

      notifier.toggle();

      expect(notifier.enabled, isFalse);
      expect(notifier.pathsForSlide(routeA), isNotEmpty);
    });

    test('clear() only removes paths for the given route', () {
      notifier
        ..startPath(routeA, const Offset(1, 1))
        ..startPath(routeB, const Offset(2, 2))
        ..clear(routeA);

      expect(notifier.pathsForSlide(routeA), isEmpty);
      expect(notifier.pathsForSlide(routeB), isNotEmpty);
    });

    test('clearAll() removes paths for every route', () {
      notifier
        ..startPath(routeA, const Offset(1, 1))
        ..startPath(routeB, const Offset(2, 2))
        ..clearAll();

      expect(notifier.pathsForSlide(routeA), isEmpty);
      expect(notifier.pathsForSlide(routeB), isEmpty);
    });

    test('clearAll() does not notify listeners when there are no paths', () {
      var notifications = 0;
      notifier
        ..addListener(() => notifications++)
        ..clearAll();

      expect(notifications, 0);
    });

    test('version increments and listeners are notified on draw and clear', () {
      var notifications = 0;
      notifier.addListener(() => notifications++);

      final initialVersion = notifier.version;

      notifier.startPath(routeA, const Offset(1, 1));
      expect(notifier.version, greaterThan(initialVersion));

      notifier.clear(routeA);
      expect(notifications, 2);
    });
  });
}
