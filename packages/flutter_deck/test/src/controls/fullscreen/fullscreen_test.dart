import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';
import 'package:flutter_deck/src/controls/fullscreen/window_proxy/window_proxy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckFullscreenManager', () {
    late _MockWindowProxy proxy;

    setUp(() {
      proxy = _MockWindowProxy();
    });

    group('canFullscreen', () {
      test('when enabled return true', () {
        proxy.canFullscreenResult = true;

        final tested = FlutterDeckFullscreenManager(proxy);

        expect(tested.canFullscreen(), isTrue);
      });

      test('when disabled return false', () {
        proxy.canFullscreenResult = false;

        final tested = FlutterDeckFullscreenManager(proxy);

        expect(tested.canFullscreen(), isFalse);
      });
    });

    group('isInFullscreen', () {
      test('initializes window proxy', () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.isInFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('when already initialized then do not initialize it again',
          () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.isInFullscreen();
        await tested.isInFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('when in full screen mode then return true', () async {
        proxy.isInFullscreenResult = true;
        final tested = FlutterDeckFullscreenManager(proxy);

        final result = await tested.isInFullscreen();

        expect(result, isTrue);
      });

      test('when not in full screen mode then return false', () async {
        proxy.isInFullscreenResult = false;
        final tested = FlutterDeckFullscreenManager(proxy);

        final result = await tested.isInFullscreen();

        expect(result, isFalse);
      });
    });

    group('enterFullscreen', () {
      test('initializes window proxy', () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.enterFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('when already initialized then do not initialize it again',
          () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.enterFullscreen();
        await tested.enterFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('entering full screen calls the proxy', () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.enterFullscreen();

        expect(proxy.isInFullscreenArgument, isTrue);
      });
    });

    group('leaveFullscreen', () {
      test('initializes window proxy', () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.leaveFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('when already initialized then do not initialize it again',
          () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.leaveFullscreen();
        await tested.leaveFullscreen();

        expect(proxy.initializeCallCount, 1);
      });

      test('leaving full screen calls the proxy', () async {
        final tested = FlutterDeckFullscreenManager(proxy);

        await tested.leaveFullscreen();

        expect(proxy.isInFullscreenArgument, isFalse);
      });
    });
  });
}

class _MockWindowProxy implements WindowProxyBase {
  int initializeCallCount = 0;
  bool canFullscreenResult = false;
  bool isInFullscreenResult = false;
  bool? isInFullscreenArgument;

  @override
  bool canFullscreen() => canFullscreenResult;

  @override
  Future<void> enterFullscreen() async => isInFullscreenArgument = true;

  @override
  Future<void> initialize() async => initializeCallCount++;

  @override
  Future<bool> isInFullscreen() async => isInFullscreenResult;

  @override
  Future<void> leaveFullscreen() async => isInFullscreenArgument = false;
}
