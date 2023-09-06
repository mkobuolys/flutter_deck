import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class DrawerSlide extends FlutterDeckSlideWidget {
  const DrawerSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/drawer',
            header: FlutterDeckHeaderConfiguration(title: 'Navigation drawer'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Did you know that flutter_deck supports navigation drawer? Just '
          'press "." on your keyboard to open it!\n\nThere, you can toggle the '
          'dark mode or navigate to any other slide straight away.\n\nOh, and '
          'if you want to update the keyboard shortcut, you can do it in the '
          'FlutterDeckConfiguration, under controls.',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
