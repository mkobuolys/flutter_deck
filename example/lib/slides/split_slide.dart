import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SplitSlide extends FlutterDeckSlideWidget {
  const SplitSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/split-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Split slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) => Center(
        child: Text(
          'Split Slide template renders two columns, one on the left and one '
          'on right.',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        ),
      ),
      rightBuilder: (context) => Center(
        child: Text(
          'If 50/50 split is not your thing, you can change the ratio based on '
          'your needs.\nAs well as background colors of each section.\nAs well '
          'as header.\nAs well as footer...',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
