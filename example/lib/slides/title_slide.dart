import 'package:flutter_deck/flutter_deck.dart';

class TitleSlide extends FlutterDeckTitleSlide {
  const TitleSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/intro',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  String get title => 'Welcome to flutter_deck example! 🚀';

  @override
  String? get subtitle => 'Use left and right arrow keys to navigate.';
}
