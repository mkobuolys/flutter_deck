import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_utils.dart';
@GenerateNiceMocks([
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckThemeNotifier>(),
])
import 'flutter_deck_slide_test.mocks.dart';

void main() {
  group('FlutterDeckSlide', () {
    late FlutterDeck flutterDeck;

    setUp(() {
      final mockRouter = MockFlutterDeckRouter();
      when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/slide-1'));
      when(mockRouter.slides).thenReturn([
        const FlutterDeckRouterSlide(
          configuration: FlutterDeckSlideConfiguration(route: '/slide-1', title: 'Slide 1'),
          route: '/slide-1',
          widget: SizedBox(),
        ),
      ]);
      when(mockRouter.currentSlideIndex).thenReturn(0);

      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(),
        router: mockRouter,
        speakerInfo: null,
        controlsNotifier: MockFlutterDeckControlsNotifier(),
        drawerNotifier: MockFlutterDeckDrawerNotifier(),
        localizationNotifier: MockFlutterDeckLocalizationNotifier(),
        markerNotifier: MockFlutterDeckMarkerNotifier(),
        presenterController: MockFlutterDeckPresenterController(),
        themeNotifier: MockFlutterDeckThemeNotifier(),
        localizationsDelegates: const [],
        supportedLocales: const [Locale('en')],
        plugins: const [],
        stepNumber: 1,
      );
    });

    testWidgets('bigFact constructor should create FlutterDeckBigFactSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.bigFact(title: 'Big Fact', theme: FlutterDeckThemeData.light()),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckBigFactSlide), findsOneWidget);
    });

    testWidgets('blank constructor should create FlutterDeckBlankSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.blank(
                builder: (context) => const Text('Blank Slide'),
                theme: FlutterDeckThemeData.light(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Blank Slide'), findsOneWidget);
    });

    testWidgets('custom constructor should create custom slide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.custom(
                builder: (context) => const Text('Custom Slide'),
                theme: FlutterDeckThemeData.light(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom Slide'), findsOneWidget);
    });

    testWidgets('image constructor should create FlutterDeckImageSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.image(
                imageBuilder: (context) => Image.memory(kTransparentImage),
                theme: FlutterDeckThemeData.light(),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckImageSlide), findsOneWidget);
    });

    testWidgets('quote constructor should create FlutterDeckQuoteSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.quote(quote: 'Quote', theme: FlutterDeckThemeData.light()),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckQuoteSlide), findsOneWidget);
    });

    testWidgets('split constructor should create FlutterDeckSplitSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.split(
                leftBuilder: (context) => const Text('Left'),
                rightBuilder: (context) => const Text('Right'),
                theme: FlutterDeckThemeData.light(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });

    testWidgets('template constructor should create FlutterDeckSlideBase', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.template(theme: FlutterDeckThemeData.light()),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckSlideBase), findsOneWidget);
    });

    testWidgets('title constructor should create FlutterDeckTitleSlide', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSlide.title(title: 'Title', theme: FlutterDeckThemeData.light()),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckTitleSlide), findsOneWidget);
    });

    group('FlutterDeckSlideWidgetX', () {
      testWidgets('withSlideConfiguration should create a slide with configuration', (tester) async {
        const configuration = FlutterDeckSlideConfiguration(route: '/slide-1');
        final slide = const SizedBox().withSlideConfiguration(configuration);

        await tester.pumpWidget(
          MaterialApp(
            home: FlutterDeckProvider(
              flutterDeck: flutterDeck,
              child: FlutterDeckTheme(data: FlutterDeckThemeData.light(), child: slide),
            ),
          ),
        );

        expect(slide, isA<FlutterDeckSlide>());
        expect((slide as FlutterDeckSlide).configuration, configuration);
      });
    });
  });
}
