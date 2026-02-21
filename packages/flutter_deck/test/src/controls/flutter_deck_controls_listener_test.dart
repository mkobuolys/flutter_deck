import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckThemeNotifier>(),
])
import 'flutter_deck_controls_listener_test.mocks.dart';

void main() {
  group('FlutterDeckControlsListener', () {
    late MockFlutterDeckControlsNotifier mockControlsNotifier;
    late MockFlutterDeckMarkerNotifier mockMarkerNotifier;
    late FlutterDeck flutterDeck;

    setUp(() {
      mockControlsNotifier = MockFlutterDeckControlsNotifier();
      mockMarkerNotifier = MockFlutterDeckMarkerNotifier();

      final mockRouter = MockFlutterDeckRouter();
      when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/slide-1'));

      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(
          controls: FlutterDeckControlsConfiguration(
            gestures: FlutterDeckGesturesConfiguration(
              supportedPlatforms: {
                TargetPlatform.android,
                TargetPlatform.iOS,
                TargetPlatform.macOS,
                TargetPlatform.linux,
                TargetPlatform.windows,
                TargetPlatform.fuchsia,
              },
            ),
          ),
        ),
        router: mockRouter,
        speakerInfo: null,
        controlsNotifier: mockControlsNotifier,
        drawerNotifier: MockFlutterDeckDrawerNotifier(),
        localizationNotifier: MockFlutterDeckLocalizationNotifier(),
        markerNotifier: mockMarkerNotifier,
        presenterController: MockFlutterDeckPresenterController(),
        themeNotifier: MockFlutterDeckThemeNotifier(),
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
      );
    });

    testWidgets('should show controls on mouse hover', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: Container(color: Colors.red, width: 100, height: 100),
            ),
          ),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);

      await tester.pump();
      await gesture.moveTo(const Offset(50, 50));
      await tester.pump();

      verify(mockControlsNotifier.showControls()).called(1);
    });

    testWidgets('should call next on tap', (tester) async {
      when(mockControlsNotifier.controlsVisible).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: Container(color: Colors.red, width: 100, height: 100),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Container));

      verify(mockControlsNotifier.next()).called(1);
      verify(mockControlsNotifier.showControls()).called(1);
    });

    testWidgets('should not call next on tap if marker enabled', (tester) async {
      when(mockControlsNotifier.controlsVisible).thenReturn(true);
      when(mockMarkerNotifier.enabled).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: Container(color: Colors.red, width: 100, height: 100),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Container));

      verifyNever(mockControlsNotifier.next());
      verify(mockControlsNotifier.showControls()).called(1);
    });

    testWidgets('should trigger next action on key press', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);

      verify(mockControlsNotifier.next()).called(1);
    });

    testWidgets('should trigger previous action on key press', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);

      verify(mockControlsNotifier.previous()).called(1);
    });

    testWidgets('should allow custom shortcut and action', (tester) async {
      var invoked = false;
      BuildContext? actionContext;

      final customFlutterDeck = FlutterDeck(
        configuration: FlutterDeckConfiguration(
          controls: FlutterDeckControlsConfiguration(
            shortcuts: FlutterDeckShortcutsConfiguration(
              customShortcuts: [
                FlutterDeckShortcut(
                  activator: const SingleActivator(LogicalKeyboardKey.keyA),
                  intent: const _MockIntent(),
                  action: _MockAction((context) {
                    invoked = true;
                    actionContext = context;
                  }),
                ),
              ],
            ),
          ),
        ),
        router: MockFlutterDeckRouter(),
        speakerInfo: null,
        controlsNotifier: mockControlsNotifier,
        drawerNotifier: MockFlutterDeckDrawerNotifier(),
        localizationNotifier: MockFlutterDeckLocalizationNotifier(),
        markerNotifier: mockMarkerNotifier,
        presenterController: MockFlutterDeckPresenterController(),
        themeNotifier: MockFlutterDeckThemeNotifier(),
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: customFlutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      await tester.sendKeyEvent(LogicalKeyboardKey.keyA);

      expect(invoked, isTrue);
      expect(actionContext?.flutterDeck, customFlutterDeck);
    });

    testWidgets('should assert when custom shortcuts clash with defaults', (tester) async {
      final customFlutterDeck = FlutterDeck(
        configuration: FlutterDeckConfiguration(
          controls: FlutterDeckControlsConfiguration(
            shortcuts: FlutterDeckShortcutsConfiguration(
              customShortcuts: [
                FlutterDeckShortcut(
                  activator: const SingleActivator(LogicalKeyboardKey.arrowRight),
                  intent: const _MockIntent(),
                  action: _MockAction((_) {}),
                ),
              ],
            ),
          ),
        ),
        router: MockFlutterDeckRouter(),
        speakerInfo: null,
        controlsNotifier: mockControlsNotifier,
        drawerNotifier: MockFlutterDeckDrawerNotifier(),
        localizationNotifier: MockFlutterDeckLocalizationNotifier(),
        markerNotifier: mockMarkerNotifier,
        presenterController: MockFlutterDeckPresenterController(),
        themeNotifier: MockFlutterDeckThemeNotifier(),
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: customFlutterDeck,
            child: FlutterDeckControlsListener(
              controlsNotifier: mockControlsNotifier,
              markerNotifier: mockMarkerNotifier,
              child: const SizedBox(),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isAssertionError);
    });
  });
}

class _MockIntent extends Intent {
  const _MockIntent();
}

class _MockAction extends ContextAction<_MockIntent> {
  _MockAction(this.onInvoke);

  final void Function(BuildContext) onInvoke;

  @override
  Object? invoke(_MockIntent intent, [BuildContext? context]) {
    onInvoke(context!);
    return null;
  }
}
