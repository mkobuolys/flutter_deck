import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class BlankSlide extends FlutterDeckSlideWidget {
  const BlankSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Blank slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Based on the configuration, this template renders a header and a '
          'footer.\nThe remaining space is free for your imagination.',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
