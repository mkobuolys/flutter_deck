import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckThemeNotifier>(),
])
import 'flutter_deck_slide_templates_test.mocks.dart';

final kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

void main() {
  late FlutterDeck flutterDeck;

  setUp(() {
    final mockRouter = MockFlutterDeckRouter();
    when(mockRouter.currentSlideConfiguration).thenReturn(const FlutterDeckSlideConfiguration(route: '/test'));

    flutterDeck = FlutterDeck(
      configuration: const FlutterDeckConfiguration(),
      router: mockRouter,
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Name',
        description: 'Description',
        socialHandle: '@handle',
        imagePath: 'assets/image.png',
      ),
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

  group('FlutterDeckBigFactSlide', () {
    testWidgets('should render title and subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: const FlutterDeckBigFactSlide(title: 'Big Fact', subtitle: 'Subtitle'),
            ),
          ),
        ),
      );

      expect(find.text('Big Fact'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });
  });

  group('FlutterDeckBlankSlide', () {
    testWidgets('should render builder content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckBlankSlide(builder: (context) => const Text('Content')),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('FlutterDeckImageSlide', () {
    testWidgets('should render image and label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckImageSlide(imageBuilder: (context) => Image.memory(kTransparentImage), label: 'Label'),
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Label'), findsOneWidget);
    });
  });

  group('FlutterDeckQuoteSlide', () {
    testWidgets('should render quote and attribution', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: const FlutterDeckQuoteSlide(quote: 'Quote', attribution: 'Attribution'),
            ),
          ),
        ),
      );

      expect(find.text('Quote'), findsOneWidget);
      expect(find.text('Attribution'), findsOneWidget);
    });
  });

  group('FlutterDeckSplitSlide', () {
    testWidgets('should render left and right content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: FlutterDeckSplitSlide(
                leftBuilder: (context) => const Text('Left'),
                rightBuilder: (context) => const Text('Right'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Left'), findsOneWidget);
      expect(find.text('Right'), findsOneWidget);
    });
  });

  group('FlutterDeckTitleSlide', () {
    testWidgets('should render title and subtitle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: TestAssetBundle(),
            child: FlutterDeckProvider(
              flutterDeck: flutterDeck,
              child: FlutterDeckTheme(
                data: FlutterDeckThemeData.light(),
                child: const FlutterDeckTitleSlide(title: 'Title', subtitle: 'Subtitle'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
    });
  });
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async => '';

  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      final data = const StandardMessageCodec().encodeMessage(<String, dynamic>{});
      return data!;
    }

    return ByteData.view(kTransparentImage.buffer);
  }
}
