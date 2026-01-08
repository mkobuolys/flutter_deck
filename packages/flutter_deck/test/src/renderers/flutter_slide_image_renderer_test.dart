import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/controls/autoplay/flutter_deck_autoplay_notifier.dart';
import 'package:flutter_deck/src/controls/flutter_deck_controls_notifier.dart';
import 'package:flutter_deck/src/controls/l10n/flutter_deck_localization_notifier.dart';
import 'package:flutter_deck/src/presenter/flutter_deck_presenter_controller.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/drawer/flutter_deck_drawer_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterSlideImageRenderer', () {
    testWidgets('render captures a slide as image', (tester) async {
      await tester.runAsync(() async {
        const renderer = FlutterSlideImageRenderer();
        const slide = SizedBox(width: 100, height: 100, child: ColoredBox(color: Colors.red));

        final router = FlutterDeckRouter(slides: []);
        final deck = FlutterDeck(
          slideRenderer: renderer,
          configuration: const FlutterDeckConfiguration(),
          router: router,
          speakerInfo: null,
          autoplayNotifier: FlutterDeckAutoplayNotifier(router: router),
          controlsNotifier: FlutterDeckControlsNotifier(
            autoplayNotifier: FlutterDeckAutoplayNotifier(router: router),
            drawerNotifier: FlutterDeckDrawerNotifier(),
            markerNotifier: FlutterDeckMarkerNotifier(),
            fullscreenManager: const _NoOpFullscreenManager(),
            router: router,
          ),
          drawerNotifier: FlutterDeckDrawerNotifier(),
          localizationNotifier: FlutterDeckLocalizationNotifier(
            supportedLocales: const [Locale('en')],
            locale: const Locale('en'),
          ),
          markerNotifier: FlutterDeckMarkerNotifier(),
          presenterController: FlutterDeckPresenterController(
            controlsNotifier: FlutterDeckControlsNotifier(
              autoplayNotifier: FlutterDeckAutoplayNotifier(router: router),
              drawerNotifier: FlutterDeckDrawerNotifier(),
              markerNotifier: FlutterDeckMarkerNotifier(),
              fullscreenManager: const _NoOpFullscreenManager(),
              router: router,
            ),
            localizationNotifier: FlutterDeckLocalizationNotifier(
              supportedLocales: const [Locale('en')],
              locale: const Locale('en'),
            ),
            markerNotifier: FlutterDeckMarkerNotifier(),
            themeNotifier: FlutterDeckThemeNotifier(ThemeMode.light),
            router: router,
          ),
          themeNotifier: FlutterDeckThemeNotifier(ThemeMode.light),
          child: const SizedBox(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: Builder(
                builder: (context) {
                  final future = renderer.render(context, slide, deck);

                  expect(future, completion(isA<Uint8List>()));

                  return const Placeholder();
                },
              ),
            ),
          ),
        );
      });
    });
  });
}

class _NoOpFullscreenManager implements FlutterDeckFullscreenManager {
  const _NoOpFullscreenManager();

  @override
  bool canFullscreen() => false;

  @override
  Future<void> enterFullscreen() async {}

  @override
  Future<bool> isInFullscreen() async => false;

  @override
  Future<void> leaveFullscreen() async {}
}
