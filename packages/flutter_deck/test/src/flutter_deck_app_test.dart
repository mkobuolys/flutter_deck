import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('FlutterDeckApp', () {
    group('slides', () {
      test('should throw AssertionError when slides list is empty', () {
        expect(
          () => FlutterDeckApp(slides: const []),
          throwsA(isA<AssertionError>().having((e) => e.message, 'message', 'You must provide at least one slide')),
        );
      });
    });

    group('navigation observers', () {
      testWidgets('adds nothing by default', (tester) async {
        await tester.pumpWidget(
          FlutterDeckApp(
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
            ],
          ),
        );

        final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
        final delegate = app.routerConfig!.routerDelegate as GoRouterDelegate;

        expect(delegate.builder.observers, isEmpty);
      });

      testWidgets('adds observer that registers slide changes', (tester) async {
        final myObserver = MyObserver();

        await tester.pumpWidget(
          FlutterDeckApp(
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-2'),
                builder: (context) => const SizedBox(),
              ),
            ],
            navigatorObservers: [myObserver],
          ),
        );

        expect(myObserver.changes, hasLength(1));

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();

        expect(myObserver.changes, hasLength(2));
      });
    });

    group('theme', () {
      testWidgets('renders with default theme mode', (tester) async {
        await tester.pumpWidget(
          FlutterDeckApp(
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
            ],
          ),
        );

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.themeMode, ThemeMode.system);
      });

      testWidgets('renders with custom theme', (tester) async {
        final lightTheme = FlutterDeckThemeData.light();
        final darkTheme = FlutterDeckThemeData.dark();

        await tester.pumpWidget(
          FlutterDeckApp(
            lightTheme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
            ],
          ),
        );

        // final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        // MaterialApp theme is not directly exposed as theme data in this way when using router,
        // but we can check if it uses the dark theme data we passed.
        // Actually MaterialApp handles theme switching.

        // Let's verify FlutterDeckTheme is present with correct data.
        final theme = tester.widget<FlutterDeckTheme>(find.byType(FlutterDeckTheme));
        expect(theme.data.materialTheme.brightness, Brightness.dark);
      });
    });

    group('locale', () {
      testWidgets('renders with default locale', (tester) async {
        await tester.pumpWidget(
          FlutterDeckApp(
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
            ],
          ),
        );

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.locale, const Locale('en', 'US'));
      });

      testWidgets('renders with custom locale', (tester) async {
        const locale = Locale('fr', 'FR');

        await tester.pumpWidget(
          FlutterDeckApp(
            locale: locale,
            supportedLocales: const [locale],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            slides: [
              FlutterDeckSlide.blank(
                configuration: const FlutterDeckSlideConfiguration(route: '/slide-1'),
                builder: (context) => const SizedBox(),
              ),
            ],
          ),
        );

        final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
        expect(materialApp.locale, locale);
      });
    });
  });
}

class MyObserver extends NavigatorObserver {
  final changes = <Route>[];

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    changes.add(topRoute);
  }
}
