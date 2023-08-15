import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class EndSlide extends FlutterDeckSlideWidget {
  const EndSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/end',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Thank you! 👋',
      subtitle: "Now it's your turn to use flutter_deck!",
    );
  }
}
