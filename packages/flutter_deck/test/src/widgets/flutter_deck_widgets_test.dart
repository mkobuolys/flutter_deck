import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../test_utils.dart';
@GenerateNiceMocks([
  MockSpec<FlutterDeckRouter>(),
  MockSpec<FlutterDeckControlsNotifier>(),
  MockSpec<FlutterDeckDrawerNotifier>(),
  MockSpec<FlutterDeckLocalizationNotifier>(),
  MockSpec<FlutterDeckMarkerNotifier>(),
  MockSpec<FlutterDeckPresenterController>(),
  MockSpec<FlutterDeckThemeNotifier>(),
])
import 'flutter_deck_widgets_test.mocks.dart';

class _MockAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'AssetManifest.bin') {
      final data = const StandardMessageCodec().encodeMessage(<String, List<Object>>{});
      return data!;
    }

    return ByteData.view(kTransparentImage.buffer);
  }
}

void main() {
  group('FlutterDeckBackground', () {
    testWidgets('solid constructor should create colored background', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: FlutterDeckBackground.solid(Colors.red)));

      final coloredBox = tester.widget<ColoredBox>(
        find.descendant(of: find.byType(FlutterDeckBackground), matching: find.byType(ColoredBox)),
      );
      expect(coloredBox.color, Colors.red);
    });
  });

  group('FlutterDeckBulletList', () {
    testWidgets('should render list items', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckTheme(
            data: FlutterDeckThemeData.light(),
            child: FlutterDeckBulletList(items: const ['Item 1', 'Item 2']),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });
  });

  group('FlutterDeckCodeHighlight', () {
    testWidgets('should render code', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckTheme(
            data: FlutterDeckThemeData.light(),
            child: const FlutterDeckCodeHighlight(code: 'void main() {}'),
          ),
        ),
      );

      expect(find.text('void main() {}'), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(RichText), findsWidgets);
    });
  });

  group('FlutterDeckFooter', () {
    late FlutterDeck flutterDeck;

    setUp(() {
      final mockRouter = MockFlutterDeckRouter();

      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(),
        router: mockRouter,
        speakerInfo: const FlutterDeckSpeakerInfo(
          name: 'Name',
          description: 'Description',
          socialHandle: '@handle',
          imagePath: 'path',
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

    testWidgets('should render footer content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: const FlutterDeckFooter(showSlideNumber: true, showSocialHandle: true),
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
      expect(find.text('@handle'), findsOneWidget);
    });
  });

  group('FlutterDeckHeader', () {
    testWidgets('should render title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckTheme(
            data: FlutterDeckThemeData.light(),
            child: FlutterDeckHeader.fromConfiguration(
              configuration: const FlutterDeckHeaderConfiguration(title: 'Title'),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });
  });

  group('FlutterDeckProgressIndicator', () {
    late FlutterDeck flutterDeck;

    setUp(() {
      final mockRouter = MockFlutterDeckRouter();

      flutterDeck = FlutterDeck(
        configuration: const FlutterDeckConfiguration(),
        router: mockRouter,
        speakerInfo: const FlutterDeckSpeakerInfo(
          name: 'Name',
          description: 'Description',
          socialHandle: '@handle',
          imagePath: 'path',
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
    testWidgets('solid constructor should create solid progress indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(flutterDeck: flutterDeck, child: const FlutterDeckProgressIndicator.solid()),
        ),
      );

      expect(find.byType(FlutterDeckProgressIndicator), findsOneWidget);
    });

    testWidgets('gradient constructor should create gradient progress indicator', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlutterDeckProvider(
            flutterDeck: flutterDeck,
            child: const FlutterDeckProgressIndicator.gradient(
              backgroundColor: Colors.black,
              gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
            ),
          ),
        ),
      );

      expect(find.byType(FlutterDeckProgressIndicator), findsOneWidget);
    });
  });

  group('FlutterDeckSpeakerInfoWidget', () {
    testWidgets('should render speaker info', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: _MockAssetBundle(),
            child: FlutterDeckTheme(
              data: FlutterDeckThemeData.light(),
              child: const FlutterDeckSpeakerInfoWidget(
                speakerInfo: FlutterDeckSpeakerInfo(
                  name: 'Name',
                  description: 'Description',
                  socialHandle: '@handle',
                  imagePath: 'path',
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('@handle'), findsOneWidget);
    });
  });
}
