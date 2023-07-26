import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class BlankSlide extends FlutterDeckBlankSlide {
  const BlankSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/blank-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Blank slide template',
            ),
          ),
        );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(
        'Based on the configuration, this template renders a header and a '
        'footer.\nThe remaining space is free for your imagination.',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
