import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class StepsSlide extends FlutterDeckSplitSlide {
  const StepsSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/steps',
            steps: 3,
            header: FlutterDeckHeaderConfiguration(title: 'Slide steps'),
          ),
        );

  @override
  Color? get rightBackgroundColor => Colors.white10;

  @override
  Widget left(BuildContext context) {
    return FlutterDeckBulletList(
      useSteps: true,
      items: const [
        'This is a step',
        'This is another step',
        'This is a third step',
      ],
    );
  }

  @override
  Widget right(BuildContext context) {
    return Center(
      child: Text(
        '"Steps" is a feature that allows you to navigate through a slide, '
        'well, step by step.\n\nYou can access the current step from any '
        'widget. This way, you can reveal or hide content, run animations, '
        'etc.\n\nFlutterDeckBulletList widget (the one on the left) supports '
        'steps out of the box.',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
