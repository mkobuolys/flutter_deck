import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The background can be defined globally for the light and dark themes separately.
- It can be a solid color, gradient, image or any custom widget.
- You can override it later for each slide.
''';

class BackgroundSlide extends FlutterDeckSlideWidget {
  const BackgroundSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/background',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Background'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      backgroundBuilder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [Colors.blue.shade900, Colors.blue.shade600]
                  : [Colors.yellow.shade100, Colors.blueGrey.shade50],
            ),
          ),
        );
      },
      builder: (context) => Center(
        child: Text(
          "Gradients make everything 10x more premium. It's a proven fact.\n\n"
          'But if you prefer solid colors, images, or even custom widgets, '
          'flutter_deck has you covered.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
