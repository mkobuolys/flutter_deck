import 'package:fake_async/fake_async.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckFullscreenManager>(),
  MockSpec<FlutterDeckRouter>(),
])
import 'flutter_deck_controls_notifier_test.mocks.dart';

void main() {
  group('FlutterDeckControlsNotifier', () {
    late MockFlutterDeckDrawerNotifier mockDrawerNotifier;
    late MockFlutterDeckMarkerNotifier mockMarkerNotifier;
    late MockFlutterDeckFullscreenManager mockFullscreenManager;
    late MockFlutterDeckRouter mockRouter;
    late FlutterDeckControlsNotifier notifier;

    setUp(() {
      mockDrawerNotifier = MockFlutterDeckDrawerNotifier();
      mockMarkerNotifier = MockFlutterDeckMarkerNotifier();
      mockFullscreenManager = MockFlutterDeckFullscreenManager();
      mockRouter = MockFlutterDeckRouter();

      notifier = FlutterDeckControlsNotifier(
        drawerNotifier: mockDrawerNotifier,
        markerNotifier: mockMarkerNotifier,
        fullscreenManager: mockFullscreenManager,
        router: mockRouter,
      );
    });

    test('next() should delegate to router and notify listeners', () {
      notifier.next();

      verify(mockRouter.next()).called(1);
    });

    test('previous() should delegate to router and notify listeners', () {
      notifier.previous();

      verify(mockRouter.previous()).called(1);
    });

    test('goToSlide() should delegate to router and notify listeners', () {
      notifier.goToSlide(1);

      verify(mockRouter.goToSlide(1)).called(1);
    });

    test('goToStep() should delegate to router and notify listeners', () {
      notifier.goToStep(1);

      verify(mockRouter.goToStep(1)).called(1);
    });

    test('toggleDrawer() should delegate to drawer notifier and notify listeners', () {
      notifier.toggleDrawer();

      verify(mockDrawerNotifier.toggle()).called(1);
    });

    test('toggleMarker() should delegate to marker notifier and notify listeners', () {
      when(mockMarkerNotifier.enabled).thenReturn(true);

      notifier.toggleMarker();

      verify(mockMarkerNotifier.toggle()).called(1);
      expect(notifier.controlsVisible, true);
    });

    group('marker enabled', () {
      setUp(() {
        when(mockMarkerNotifier.enabled).thenReturn(true);
        notifier.toggleMarker(); // enable it
      });

      test('should disable GoNextIntent', () {
        expect(notifier.intentDisabled(const GoNextIntent()), true);
      });

      test('should disable GoPreviousIntent', () {
        expect(notifier.intentDisabled(const GoPreviousIntent()), true);
      });

      test('should disable ToggleDrawerIntent', () {
        expect(notifier.intentDisabled(const ToggleDrawerIntent()), true);
      });
    });

    group('marker disabled', () {
      setUp(() {
        when(mockMarkerNotifier.enabled).thenReturn(false);
        notifier.toggleMarker(); // disable it
      });

      test('should not disable GoNextIntent', () {
        expect(notifier.intentDisabled(const GoNextIntent()), false);
      });
    });

    test('showControls() should set controlsVisible to true', () {
      notifier.showControls();
      expect(notifier.controlsVisible, true);
    });

    test('showControls() should hide controls after duration', () async {
      fakeAsync((async) {
        notifier.showControls();
        expect(notifier.controlsVisible, true);

        async.elapse(const Duration(seconds: 3));
        expect(notifier.controlsVisible, false);
      });
    });

    test('toggleControlsVisibleDuration() should toggle duration', () {
      fakeAsync((async) {
        notifier
          ..toggleControlsVisibleDuration() // Infinite
          ..showControls();

        async.elapse(const Duration(seconds: 3));
        expect(notifier.controlsVisible, true); // Still visible

        async.elapse(const Duration(hours: 23));
        expect(notifier.controlsVisible, true); // Still visible based on logic

        notifier
          ..toggleControlsVisibleDuration() // Back to 3s
          ..showControls();
        async.elapse(const Duration(seconds: 3));
        expect(notifier.controlsVisible, false);
      });
    });

    test('fullscreen methods should delegate to fullscreen manager', () {
      notifier.canFullscreen();
      verify(mockFullscreenManager.canFullscreen()).called(1);

      notifier.isInFullscreen();
      verify(mockFullscreenManager.isInFullscreen()).called(1);

      notifier.enterFullscreen();
      verify(mockFullscreenManager.enterFullscreen()).called(1);

      notifier.leaveFullscreen();
      verify(mockFullscreenManager.leaveFullscreen()).called(1);
    });
  });
}
