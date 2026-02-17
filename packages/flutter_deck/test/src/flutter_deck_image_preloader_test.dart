import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck_image_preloader.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<FlutterDeckRouter>()])
import 'flutter_deck_image_preloader_test.mocks.dart';

void main() {
  group('FlutterDeckImagePreloader', () {
    late MockFlutterDeckRouter mockRouter;
    late FlutterDeckImagePreloader preloader;
    late List<String> precachedImages;

    Future<void> mockImagePrecacher(ImageProvider provider, BuildContext context) async {
      if (provider is AssetImage) {
        precachedImages.add(provider.assetName);
      } else if (provider is NetworkImage) {
        precachedImages.add(provider.url);
      }
    }

    setUp(() {
      mockRouter = MockFlutterDeckRouter();
      precachedImages = [];
      preloader = FlutterDeckImagePreloader(router: mockRouter, imagePrecacher: mockImagePrecacher);

      // Mock navigator key and context
      final navigatorKey = GlobalKey<NavigatorState>();
      when(mockRouter.navigatorKey).thenReturn(navigatorKey);
    });

    testWidgets('init adds listener to router', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Container()));
      // Hack to attach the key to a context
      when(mockRouter.navigatorKey).thenReturn(GlobalKey<NavigatorState>());
      // We don't actually need a valid context for this test, just for the preloader to not crash if accessed

      preloader.init();

      verify(mockRouter.addListener(any)).called(1);
    });

    test('dispose removes listener from router', () {
      preloader.dispose();

      verify(mockRouter.removeListener(any)).called(1);
    });

    testWidgets('preloads images for the next 2 slides', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Attach the key to this context
              (mockRouter.navigatorKey as GlobalKey).currentState;
              return Container();
            },
          ),
        ),
      );

      final slides = [
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/1'),
          route: '/1',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/2', preloadImages: {'assets/image1.png'}),
          route: '/2',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/3',
            preloadImages: {'https://element.com/image2.png'},
          ),
          route: '/3',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/4', preloadImages: {'assets/image3.png'}),
          route: '/4',
          widget: Container(),
        ),
      ];

      when(mockRouter.slides).thenReturn(slides);
      when(mockRouter.currentSlideIndex).thenReturn(0);

      final key = GlobalKey<NavigatorState>();
      when(mockRouter.navigatorKey).thenReturn(key);

      await tester.pumpWidget(MaterialApp(navigatorKey: key, home: Container()));

      preloader.init();

      expect(precachedImages, containsAll(['assets/image1.png', 'https://element.com/image2.png']));
      expect(precachedImages, isNot(contains('assets/image3.png')));
    });

    testWidgets('does not preload duplicates', (tester) async {
      final key = GlobalKey<NavigatorState>();
      when(mockRouter.navigatorKey).thenReturn(key);
      await tester.pumpWidget(MaterialApp(navigatorKey: key, home: Container()));

      final slides = [
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/1'),
          route: '/1',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/2', preloadImages: {'assets/image1.png'}),
          route: '/2',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/3', preloadImages: {'assets/image1.png'}),
          route: '/3',
          widget: Container(),
        ),
      ];

      when(mockRouter.slides).thenReturn(slides);
      when(mockRouter.currentSlideIndex).thenReturn(0);

      preloader.init();

      expect(precachedImages.where((i) => i == 'assets/image1.png').length, 1);
    });

    testWidgets('handles empty configuration', (tester) async {
      final key = GlobalKey<NavigatorState>();
      when(mockRouter.navigatorKey).thenReturn(key);
      await tester.pumpWidget(MaterialApp(navigatorKey: key, home: Container()));

      final slides = [
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/1'),
          route: '/1',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/2'),
          route: '/2',
          widget: Container(),
        ),
      ];

      when(mockRouter.slides).thenReturn(slides);
      when(mockRouter.currentSlideIndex).thenReturn(0);

      preloader.init();

      expect(precachedImages, isEmpty);
    });

    testWidgets('handles boundary conditions (end of slides)', (tester) async {
      final key = GlobalKey<NavigatorState>();
      when(mockRouter.navigatorKey).thenReturn(key);
      await tester.pumpWidget(MaterialApp(navigatorKey: key, home: Container()));

      final slides = [
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/1'),
          route: '/1',
          widget: Container(),
        ),
        FlutterDeckRouterSlide(
          configuration: const FlutterDeckSlideConfiguration(route: '/2'),
          route: '/2',
          widget: Container(),
        ),
      ];

      when(mockRouter.slides).thenReturn(slides);
      when(mockRouter.currentSlideIndex).thenReturn(1); // Last slide

      preloader.init();

      expect(precachedImages, isEmpty); // Should not crash and preload nothing
    });
  });
}
