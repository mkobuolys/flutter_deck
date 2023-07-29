import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class LayoutStructureSlide extends FlutterDeckSlideBase {
  const LayoutStructureSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/layout-structure',
          ),
        );

  @override
  Widget? content(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Content goes here...\n\nThis is how the default layout structure '
            'looks like.\nIn the next few slides, you will find some pre-built '
            'slide templates.',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: colorScheme.onBackground),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget? footer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Footer goes here...',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }

  @override
  Widget? header(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Header goes here...',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
