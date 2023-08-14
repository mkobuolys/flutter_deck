import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class HiddenSlide extends FlutterDeckSlideWidget {
  const HiddenSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/hidden',
            hidden: true,
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      child: Center(
        child: Text(
          "This slide is hidden. Oh, but you can't see it...",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
