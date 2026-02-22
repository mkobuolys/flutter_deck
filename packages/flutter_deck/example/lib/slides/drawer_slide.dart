import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- Use the drawer to navigate to any slide.
- You can open it with "." or the slide number button in the deck controls.
- You can override default keyboard bindings in the FlutterDeckConfiguration.
''';

class DrawerSlide extends FlutterDeckSlideWidget {
  const DrawerSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/drawer',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Navigation drawer'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Slide navigation, right in your pocket.\n\n'
          'Press "." or use the deck controls to open the drawer and jump around!',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
