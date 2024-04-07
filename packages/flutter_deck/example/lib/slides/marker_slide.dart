import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MarkerSlide extends FlutterDeckSlideWidget {
  const MarkerSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/marker',
            header: FlutterDeckHeaderConfiguration(
              title: 'Marker tool',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          children: [
            Text(
              'If you want to highlight something, you can use the marker '
              'tool. The tool is available in the options menu in the deck '
              'controls, or press "M" on your keyboard. The keyboard binding '
              'can be overridden in the configuration.\n\nYou can also update '
              'the marker color and stroke width in the global configuration.'
              '\n\nTry out the tool by drawing a face for this good boi!',
              style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Image.asset('assets/dog_complete_drawing.jpeg'),
            ),
          ],
        ),
      ),
    );
  }
}
