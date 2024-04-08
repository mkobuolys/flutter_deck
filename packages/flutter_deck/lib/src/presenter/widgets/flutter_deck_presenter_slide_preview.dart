import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Renders the preview of the current and next slide.
///
/// This widget is used in the presenter view to display the current slide and
/// the next slide.
class FlutterDeckPresenterSlidePreview extends StatelessWidget {
  /// Creates a [FlutterDeckPresenterSlidePreview] widget.
  const FlutterDeckPresenterSlidePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.flutterDeck.router;

    return ListenableBuilder(
      listenable: router,
      builder: (context, child) {
        final currentSlideIndex = router.currentSlideIndex;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _SlidePreview(
                  index: currentSlideIndex,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SlidePreview(
                  index: currentSlideIndex + 1,
                  next: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SlidePreview extends StatelessWidget {
  const _SlidePreview({
    required this.index,
    this.next = false,
  });

  final int index;
  final bool next;

  String _getHeader(int slideCount) {
    if (index >= slideCount) return 'End of presentation';

    final slideInfo = 'Slide ${index + 1} of $slideCount';

    return next ? 'Next: $slideInfo' : 'Current: $slideInfo';
  }

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final slideSize = flutterDeck.globalConfiguration.slideSize;
    final slides = flutterDeck.router.slides;

    return Column(
      children: [
        Text(_getHeader(slides.length)),
        const SizedBox(height: 8),
        Expanded(
          child: index < slides.length
              ? FittedBox(
                  child: Container(
                    color:
                        FlutterDeckTheme.of(context).slideTheme.backgroundColor,
                    height: slideSize.height,
                    width: slideSize.width,
                    child: AbsorbPointer(
                      child: slides[index].widget.build(context),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
