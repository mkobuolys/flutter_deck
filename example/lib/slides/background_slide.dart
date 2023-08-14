import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class BackgroundSlide extends FlutterDeckSlideWidget {
  const BackgroundSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/background',
            header: FlutterDeckHeaderConfiguration(title: 'Background'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'It is possible to define a global background for the light and dark '
          'themes separately. The background could be a solid color, gradient, '
          'image or any custom widget. Of course, you can override it later '
          'for each slide, too.\n\nToggle dark mode to see this in action',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
