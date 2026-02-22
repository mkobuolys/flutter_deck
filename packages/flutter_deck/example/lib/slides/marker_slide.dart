import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- If you want to highlight something, you can use the marker tool.
- The tool is available in the options menu in the deck controls.
- You can also update the marker color and stroke width in the global configuration.
''';

class MarkerSlide extends FlutterDeckSlideWidget {
  const MarkerSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/marker',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Marker tool'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          children: [
            Text(
              'Draw on the screen!\n'
              'Because sometimes you just need to circle things.\n'
              'Press "M" to use the marker tool. Try drawing a face for this '
              'good boi!',
              style: FlutterDeckTheme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(child: Image.asset('assets/dog_complete_drawing.jpeg')),
          ],
        ),
      ),
    );
  }
}
