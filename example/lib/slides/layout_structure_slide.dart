import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class LayoutStructureSlide extends FlutterDeckSlideWidget {
  const LayoutStructureSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/layout-structure',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.template(
      backgroundBuilder: (context) => FlutterDeckBackground.solid(
        Theme.of(context).colorScheme.background,
      ),
      contentBuilder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Content goes here...\n\nThis is how the default layout '
              'structure looks like.\nIn the next few slides, you will find '
              'some pre-built slide templates.',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      footerBuilder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Footer goes here...',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ),
      ),
      headerBuilder: (context) => ColoredBox(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Header goes here...',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
