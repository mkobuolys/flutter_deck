import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Renders the preview of the current and next slide.
///
/// This widget is used in the presenter view to display the current slide and
/// the next slide.
class FlutterDeckPresenterSlidePreview extends StatelessWidget {
  /// Creates a [FlutterDeckPresenterSlidePreview] widget.
  FlutterDeckPresenterSlidePreview({super.key})
      : autoSizeGroup = AutoSizeGroup();

  /// The auto size group for the text widgets.
  final AutoSizeGroup autoSizeGroup;

  @override
  Widget build(BuildContext context) {
    final router = context.flutterDeck.router;

    return ListenableBuilder(
      listenable: router,
      builder: (context, child) {
        final FlutterDeckRouter(
          :currentSlideConfiguration,
          :currentSlideIndex,
          :currentStep
        ) = router;
        final slideSteps = currentSlideConfiguration.steps;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: _SlidePreview(
                  autoSizeGroup: autoSizeGroup,
                  index: currentSlideIndex,
                  step: currentStep,
                  steps: slideSteps,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: _SlidePreview(
                  autoSizeGroup: autoSizeGroup,
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
    required this.autoSizeGroup,
    required this.index,
    this.next = false,
    this.step,
    this.steps,
  });

  final AutoSizeGroup autoSizeGroup;
  final int index;
  final bool next;
  final int? step;
  final int? steps;

  String _getHeader(int slideCount) {
    var slideInfo = 'Slide ${index + 1} of $slideCount';

    if (step != null && (steps ?? 1) > 1) {
      slideInfo += ' (step $step of $steps)';
    }

    return next ? 'Next: $slideInfo' : 'Current: $slideInfo';
  }

  String _getSlideTitle(FlutterDeckRouterSlide slide) {
    final configuration = slide.configuration;
    final title = configuration.title;

    if (title != null) return title;

    final header = configuration.header;

    if (header.showHeader) return header.title;

    return configuration.route;
  }

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final slideSize = flutterDeck.globalConfiguration.slideSize;
    final slides = flutterDeck.router.slides;
    final aspectRatio =
        slideSize.isResponsive ? 16 / 9 : slideSize.width! / slideSize.height!;
    final isLastSlide = index >= slides.length;

    return Column(
      children: [
        Text(isLastSlide ? '' : _getHeader(slides.length)),
        const SizedBox(height: 8),
        Expanded(
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: isLastSlide
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: _SlideTitle(
                        autoSizeGroup: autoSizeGroup,
                        color: Theme.of(context).colorScheme.onSurface,
                        title: 'End of presentation',
                      ),
                    ),
                  )
                : Container(
                    color: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: _SlideTitle(
                        autoSizeGroup: autoSizeGroup,
                        color: Theme.of(context).colorScheme.onSecondary,
                        title: _getSlideTitle(slides[index]),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _SlideTitle extends StatelessWidget {
  const _SlideTitle({
    required this.autoSizeGroup,
    required this.color,
    required this.title,
  });

  final AutoSizeGroup autoSizeGroup;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      group: autoSizeGroup,
      maxLines: 1,
      style: FlutterDeckTheme.of(context)
          .textTheme
          .bodyLarge
          .copyWith(color: color, fontWeight: FontWeight.w500),
    );
  }
}
