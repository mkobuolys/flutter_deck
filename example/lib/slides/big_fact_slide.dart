import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class BigFactSlide extends FlutterDeckSlideWidget {
  const BigFactSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/bigFact',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: 'Let\'s Start with the decks!',
      subtitle:
          'Flutter Deck is a Flutter package that helps you create slide decks in Flutter.',
      theme: FlutterDeckTheme.of(context).copyWith(
          bigFactSlideTheme: const FlutterDeckBigFactSlideThemeData(
              titleTextStyle: TextStyle(color: Colors.amber))),
    );
  }
}
