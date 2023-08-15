import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class StepsSlide extends FlutterDeckSlideWidget {
  const StepsSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/steps',
            steps: 3,
            header: FlutterDeckHeaderConfiguration(title: 'Slide steps'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => FlutterDeckBulletList(
        useSteps: true,
        items: const [
          'This is a step',
          'This is another step',
          'This is a third step',
        ],
      ),
      rightBuilder: (context) => Center(
        child: Text(
          '"Steps" is a feature that allows you to navigate through a slide, '
          'well, step by step.\n\nYou can access the current step from any '
          'widget. This way, you can reveal or hide content, run animations, '
          'etc.\n\nFlutterDeckBulletList widget (the one on the left) supports '
          'steps out of the box.',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
