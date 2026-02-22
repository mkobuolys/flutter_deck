import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- flutter_deck comes with a few built-in transitions.
- You can also create one of your own.
''';

class TransitionsSlide extends FlutterDeckSlideWidget {
  const TransitionsSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/transitions',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Slide transitions'),
          transition: FlutterDeckTransition.rotation(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) =>
          FlutterDeckBulletList(items: const ['None (default)', 'Fade', 'Scale', 'Slide', 'Rotation', 'Custom']),
      rightBuilder: (context) => Center(
        child: Text(
          'Smooth operators.\n\n'
          'flutter_deck comes with a few built-in transitions, but you can also '
          'create your own.\n\nAs you saw, this slide uses a '
          '"Rotation" transition 😵‍💫',
          style: FlutterDeckTheme.of(context).textTheme.title,
        ),
      ),
    );
  }
}
