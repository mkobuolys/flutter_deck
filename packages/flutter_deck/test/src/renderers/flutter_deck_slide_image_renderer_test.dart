import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'flutter_deck_slide_image_renderer_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterDeck>()])
void main() {
  group('FlutterDeckSlideImageRenderer', () {
    late MockFlutterDeck mockFlutterDeck;

    setUp(() {
      mockFlutterDeck = MockFlutterDeck();
    });

    test('default instantiation', () {
      final renderer = FlutterDeckSlideImageRenderer(flutterDeck: mockFlutterDeck);

      expect(renderer, isNotNull);
    });

    testWidgets('disposes the rendered slide once the image is captured', (tester) async {
      late BuildContext deckContext;
      var disposed = false;

      await tester.pumpWidget(FlutterDeckApp(slides: [_ContextSlide(onBuild: (context) => deckContext = context)]));
      await tester.pumpAndSettle();

      final renderer = FlutterDeckSlideImageRenderer(flutterDeck: deckContext.flutterDeck);
      final image = await tester.runAsync(
        () => renderer.render(deckContext, _DisposeProbe(onDispose: () => disposed = true), stepNumber: 1),
      );

      expect(image, isNotEmpty);
      expect(disposed, isTrue);
    });
  });
}

class _ContextSlide extends FlutterDeckSlideWidget {
  const _ContextSlide({required this.onBuild})
    : super(configuration: const FlutterDeckSlideConfiguration(route: '/slide'));

  final ValueChanged<BuildContext> onBuild;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
      onBuild(context);
      return const SizedBox.expand();
    },
  );
}

class _DisposeProbe extends StatefulWidget {
  const _DisposeProbe({required this.onDispose});

  final VoidCallback onDispose;

  @override
  State<_DisposeProbe> createState() => _DisposeProbeState();
}

class _DisposeProbeState extends State<_DisposeProbe> {
  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.expand();
}
