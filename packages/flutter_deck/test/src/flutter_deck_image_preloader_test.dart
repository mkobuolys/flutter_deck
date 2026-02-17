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

    setUp(() {
      mockRouter = MockFlutterDeckRouter();
      preloader = FlutterDeckImagePreloader(router: mockRouter);
    });

    test('init adds listener to router', () {
      preloader.init();

      verify(mockRouter.addListener(any)).called(1);
    });

    test('dispose removes listener from router', () {
      preloader.dispose();

      verify(mockRouter.removeListener(any)).called(1);
    });
  });
}
