import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The template slide template renders a header, a footer, and a content area.
''';

class LayoutStructureSlide extends FlutterDeckSlideWidget {
  const LayoutStructureSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/layout-structure',
            speakerNotes: _speakerNotes,
            title: 'Layout structure',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.template(
      backgroundBuilder: (context) => FlutterDeckBackground.solid(
        Theme.of(context).colorScheme.background,
      ),
      contentBuilder: (context) => Center(
        child: Text(
          'Content goes here...\n\nThis is how the default slide layout '
          'structure looks like.\nIn the next few slides, you will find some '
          'pre-built slide templates.',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
      footerBuilder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return ColoredBox(
          color: colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Footer goes here...',
                style: FlutterDeckTheme.of(context)
                    .textTheme
                    .bodyMedium
                    .copyWith(color: colorScheme.onSecondary),
              ),
            ),
          ),
        );
      },
      headerBuilder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return ColoredBox(
          color: colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Header goes here...',
                style: FlutterDeckTheme.of(context)
                    .textTheme
                    .bodyMedium
                    .copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
        );
      },
    );
  }
}
