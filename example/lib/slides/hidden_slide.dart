import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class HiddenSlide extends FlutterDeckBlankSlide {
  const HiddenSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/hidden',
            hidden: true,
          ),
        );

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(
        "This slide is hidden. Oh, but you can't see it...",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
