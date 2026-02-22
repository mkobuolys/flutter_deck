import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- Use steps to navigate through a slide step by step.
- You can access the current step from any widget.
- FlutterDeckBulletList widget supports steps out of the box.
''';

class StepsSlide extends FlutterDeckSlideWidget {
  const StepsSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/steps',
          steps: 3,
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Slide steps'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => FlutterDeckBulletList(
        useSteps: true,
        items: const ['This is a step', 'This is another step', 'This is a third step'],
      ),
      rightBuilder: (context) => Center(
        child: Text(
          'Step. By. Step.\n\nBuilding up ideas piece by piece keeps your '
          'audience engaged.\n\nFlutterDeckBulletList supports '
          'steps out of the box, or use the current step to animate any custom '
          'widget.',
          style: FlutterDeckTheme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
